require 'rails_helper'

RSpec.describe CardsController, type: :request do
  let(:card) { create(:card) }
  let(:user) { create(:user) }

  before do
    post session_path, params: {
      email_address: user.email_address,
      password: "password"
    }
  end


  describe "GET #index" do
    it "returns a success response" do
      get cards_path
      expect(response).to be_successful
    end

    it "returns a success response with search query" do
      get cards_path, params: { q: card.name }
      expect(response).to be_successful
    end

    it "return login page response when user is not authenticated" do
      delete session_path(user.id)
      get cards_path
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      allow(Card).to receive(:includes).and_return(Card)
      allow(Card).to receive(:find).and_return(card)
      get card_path(card.id)
      expect(response).to be_successful
    end

    it "returns a 404 response for a non-existent card" do
      get card_path(id: 9999)
      expect(response).to have_http_status(:not_found)
    end

    it "returns a 404 response for an invalid card ID" do
      get card_path(id: "invalid")
      expect(response).to have_http_status(:not_found)
    end

    it "retur login page response when user is not authenticated" do
      delete session_path(user.id)
      get card_path(card.id)
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get new_card_path
      expect(response).to be_successful
    end

    it "returns a login page when the user is not authenticated" do
      delete session_path(user.id)
      get new_card_path
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      allow(Card).to receive(:find).and_return(card)
      get edit_card_path(card)
      expect(response).to be_successful
    end

    it "returns a login page when the user is not authenticated" do
      delete session_path(user.id)
      get edit_card_path(card)
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "POST #create" do
    it "creates a new Card" do
      expect {
        attrs = attributes_for(:card, language_id: card.language_id, mtg_set_id: card.mtg_set_id, currency_id: card.currency_id)
        post cards_path, params: attrs
      }.to change(Card, :count).by(1)
    end

    it "returns error response when val is nil" do
      attrs = attributes_for(:card, language_id: card.language_id, mtg_set_id: card.mtg_set_id, currency_id: card.currency_id)
      Card.delete_all

      attrs.each do |key, value|
        if key != :scryfall_id
          expect {
            post cards_path, params:  attrs.merge(key => nil)
          }.not_to change(Card, :count)
          expect(response).to have_http_status(400)
        end
      end

      expect(Card.count).to eq(0)
      expect(Card.new(attrs).valid?).to be_truthy
    end

    it "returns a login page when the user is not authenticated" do
      delete session_path(user.id)
      attrs = attributes_for(:card, language_id: card.language_id, mtg_set_id: card.mtg_set_id, currency_id: card.currency_id)
      post cards_path, params: attrs
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "PATCH #update" do
    it "updates the requested card" do
      allow(Card).to receive(:find).and_return(card)
      patch card_path(card.id), params: { card: { name: "NewName" } }
      expect(response).to redirect_to(card_path(card.id))
    end

    it "returns error response when val is nil" do
      allow(Card).to receive(:find).and_return(card)
      patch card_path(card.id), params: { card: { name: nil } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it "returns a login page when the user is not authenticated" do
      delete session_path(user.id)
      patch card_path(card.id), params: { card: { name: "NewName" } }
      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(new_session_path)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested card" do
      allow(Card).to receive(:find).and_return(card)
      allow(card).to receive(:destroy!).and_return(true)
      delete card_path(card.id)
      expect(response).to be_redirect
    end

    it "returns a 404 response for a non-existent card" do
      delete card_path(id: 9999)
      expect(response).to have_http_status(:not_found)
    end

    it "returns a 404 response for an invalid card ID" do
      delete card_path(id: "invalid")
      expect(response).to have_http_status(:not_found)
    end

    it "returns a login page when the user is not authenticated" do
      delete session_path(user.id)
      delete card_path(card.id)
      expect(response).to have_http_status(:found)
    end
  end
end
