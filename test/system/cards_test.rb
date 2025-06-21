require "application_system_test_case"

class CardsTest < ApplicationSystemTestCase
  setup do
    @card = cards(:one)
  end

  test "visiting the index" do
    visit cards_url
    assert_selector "h1", text: "Cards"
  end

  test "should create card" do
    visit cards_url
    click_on "New card"

    check "Altered" if @card.altered
    fill_in "Condition", with: @card.condition
    fill_in "Coolector number", with: @card.coolector_number
    fill_in "Currency", with: @card.currency
    check "Foil" if @card.foil
    fill_in "Language", with: @card.language
    check "Misprint" if @card.misprint
    fill_in "Name", with: @card.name
    fill_in "Price", with: @card.price
    fill_in "Quantity", with: @card.quantity
    fill_in "Rarity", with: @card.rarity
    fill_in "Scryfall", with: @card.scryfall_id
    fill_in "Set code", with: @card.set_code
    fill_in "Set name", with: @card.set_name
    click_on "Create Card"

    assert_text "Card was successfully created"
    click_on "Back"
  end

  test "should update Card" do
    visit card_url(@card)
    click_on "Edit this card", match: :first

    check "Altered" if @card.altered
    fill_in "Condition", with: @card.condition
    fill_in "Coolector number", with: @card.coolector_number
    fill_in "Currency", with: @card.currency
    check "Foil" if @card.foil
    fill_in "Language", with: @card.language
    check "Misprint" if @card.misprint
    fill_in "Name", with: @card.name
    fill_in "Price", with: @card.price
    fill_in "Quantity", with: @card.quantity
    fill_in "Rarity", with: @card.rarity
    fill_in "Scryfall", with: @card.scryfall_id
    fill_in "Set code", with: @card.set_code
    fill_in "Set name", with: @card.set_name
    click_on "Update Card"

    assert_text "Card was successfully updated"
    click_on "Back"
  end

  test "should destroy Card" do
    visit card_url(@card)
    click_on "Destroy this card", match: :first

    assert_text "Card was successfully destroyed"
  end
end
