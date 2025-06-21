json.extract! card, :id, :name, :set_code, :set_name, :coolector_number, :foil, :rarity, :quantity, :scryfall_id, :price, :misprint, :altered, :condition, :language, :currency, :created_at, :updated_at
json.url card_url(card, format: :json)
