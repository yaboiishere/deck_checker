FactoryBot.define do
  factory :card do
    name { "Test Card" }
    collector_number { "001" }
    foil { false }
    altered { false }
    misprint { false }
    condition { "near_mint" }
    quantity { 1 }
    scryfall_id { SecureRandom.hex(8) }
    price { 0.99 }
    rarity { "common" }
    association :language
    association :currency
    association :mtg_set
  end
end
