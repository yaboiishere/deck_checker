module Parsers::ManaboxCsv
  require "csv"

  # Binder Name,Binder Type,Name,Set code,Set name,Collector number,Foil,Rarity,Quantity,
  # ManaBox ID,Scryfall ID,Purchase price,Misprint,Altered,Condition,Language,Purchase price currency
  def self.csv_to_cards(user_id, file_path)
    languages = Language.all.index_by(&:code)
    currencies = Currency.all.index_by(&:code)
    mtg_sets = MtgSet.all.index_by(&:name)
    begin
    ActiveRecord::Base.transaction do
        CSV.foreach(file_path, headers: true) do |row|
          set_name =  row["Set name"]
          set = mtg_sets[set_name]

          language = languages[row["Language"]]
          currency = currencies[row["Purchase price currency"]]

          attrs = {
            name: row["Name"],
            collector_number: row["Collector number"],
            foil: row["Foil"] == "foil",
            rarity: row["Rarity"],
            scryfall_id: row["Scryfall ID"],
            misprint: row["Misprint"] == "true",
            altered: row["Altered"] == "true",
            condition: row["Condition"],
            language: language,
            mtg_set: set

          }

          card = Card.find_by(attrs)

          card =
            if card.nil?
              c = Card.new(attrs).tap do |c|
                c.currency = currency
                c.price = row["Purchase price"].to_f
              end

              if c.save
                c
              else
                ImportError.create!(user_id: user_id, file_name: file_path, error_message: c.errors.full_messages.join(", "))
                next
              end
            else
              card
            end

          collection = Collection.find_by(user_id: user_id, card_id: card.id)
          quantity = row["Quantity"].to_i

          if collection.nil?
            Collection.create!(user_id: user_id, card_id: card.id, quantity: quantity)
          else
            collection
              .lock!
              .update!(quantity: collection.quantity + quantity)
          end
        end
      end
      :success

    rescue => err
      err.message
    end
  end
end
