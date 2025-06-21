require "test_helper"

class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @card = cards(:one)
  end

  test "should get index" do
    get cards_url
    assert_response :success
  end

  test "should get new" do
    get new_card_url
    assert_response :success
  end

  test "should create card" do
    assert_difference("Card.count") do
      post cards_url, params: { card: { altered: @card.altered, condition: @card.condition, coolector_number: @card.coolector_number, currency: @card.currency, foil: @card.foil, language: @card.language, misprint: @card.misprint, name: @card.name, price: @card.price, quantity: @card.quantity, rarity: @card.rarity, scryfall_id: @card.scryfall_id, set_code: @card.set_code, set_name: @card.set_name } }
    end

    assert_redirected_to card_url(Card.last)
  end

  test "should show card" do
    get card_url(@card)
    assert_response :success
  end

  test "should get edit" do
    get edit_card_url(@card)
    assert_response :success
  end

  test "should update card" do
    patch card_url(@card), params: { card: { altered: @card.altered, condition: @card.condition, coolector_number: @card.coolector_number, currency: @card.currency, foil: @card.foil, language: @card.language, misprint: @card.misprint, name: @card.name, price: @card.price, quantity: @card.quantity, rarity: @card.rarity, scryfall_id: @card.scryfall_id, set_code: @card.set_code, set_name: @card.set_name } }
    assert_redirected_to card_url(@card)
  end

  test "should destroy card" do
    assert_difference("Card.count", -1) do
      delete card_url(@card)
    end

    assert_redirected_to cards_url
  end
end
