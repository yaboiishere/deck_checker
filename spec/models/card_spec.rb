require "rails_helper"

RSpec.describe Card, type: :model do
  subject do
    described_class.new(
      name: "Lightning Bolt",
      collector_number: "150",
      foil: false,
      altered: false,
      misprint: false,
      condition: "near_mint",
      quantity: 1,
      price: 1.25,
      scryfall_id: "abc123",
      rarity: "common",
      mtg_set: create(:mtg_set),
      language: create(:language),
      currency: create(:currency),
    )
  end

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is invalid if a duplicate with same scoped fields exists" do
    subject.save!
    duplicate = subject.dup
    expect(duplicate).not_to be_valid
    expect(duplicate.errors[:name]).to include(Card::CONSTRAINT_ERROR)
  end

  it "belongs to a language" do
    expect(subject).to respond_to(:language)
  end

  it "belongs to a currency" do
    expect(subject).to respond_to(:currency)
  end

  it "belongs to a mtg_set" do
    expect(subject).to respond_to(:mtg_set)
  end
end
