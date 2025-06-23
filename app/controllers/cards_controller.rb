class CardsController < ApplicationController
  allow_unauthenticated_access only: %i[ index show ]
  before_action :set_card, only: %i[ show edit update destroy ]

  # GET /cards or /cards.json
  def index
    @cards = Card.includes([ :language, :currency, :mtg_set ]).order(:name)
    if params[:q].present?
      @cards = @cards.where("name ILIKE ?", "%#{params[:q]}%")
    end

    @cards = @cards.page(params[:page])
  end

  # GET /cards/1 or /cards/1.json
  def show
    @card = Card.includes([ :language, :currency, :mtg_set ]).find(params.expect(:id))
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards or /cards.json
  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to @card, notice: "Card was successfully created." }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cards/1 or /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card, notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    @card.destroy!

    respond_to do |format|
      format.html { redirect_to cards_path, status: :see_other, notice: "Card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.expect(card: [ :name, :mtg_set_id, :coolector_number, :foil, :rarity, :quantity, :scryfall_id, :price, :misprint, :altered, :condition, :language_id, :currency_id ])
    end
end
