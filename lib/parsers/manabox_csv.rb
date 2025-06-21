module Parsers::ManaboxCsv
  require "csv"

  # Binder Name,Binder Type,Name,Set code,Set name,Collector number,Foil,Rarity,Quantity,
  # ManaBox ID,Scryfall ID,Purchase price,Misprint,Altered,Condition,Language,Purchase price currency
  def self.csv_to_cards(path)
    csv_path = Rails.root.join(path)

    ActiveRecord::Base.transaction do
      CSV.foreach(csv_path, headers: true) do |row|
        set = find_set(row["Set code"], row["Set name"])
        if set.nil? then
          error_message = "Set not found for code: #{row['Set code']} or name: #{row['Set name']}"
          raise ActiveRecord::RecordNotFound, error_message
        end

        language = Language.find_by(code: row["Language"])
        currency = Currency.find_by(code: row["Purchase price currency"])

      card = Card.new(
          name: row["Name"],
          collector_number: row["Collector number"],
          foil: row["Foil"] == "Yes",
          rarity: row["Rarity"],
          quantity: row["Quantity"].to_i,
          scryfall_id: row["Scryfall ID"],
          misprint: row["Misprint"] == "Yes",
          altered: row["Altered"] == "Yes",
          price: row["Purchase price"].to_f,
          condition: row["Condition"],
          language_id: language.id,
          currency_id: currency.id,
          mtg_set_id: set.id
      )
      begin
          card.save!
      rescue ActiveRecord::RecordInvalid => e

          if e.message =~ Regexp.new(Card::CONSTRAINT_ERROR) then
            old_record =
              Card
              .find_by(
                name: card.name,
                mtg_set_id: card.mtg_set_id,
                collector_number: card.collector_number,
                language_id: card.language_id,
                condition: card.condition,
                foil: card.foil,
                altered: card.altered,
                misprint: card.misprint)
              .lock!

            old_record.quantity += card.quantity

            old_record.save!
          else
          raise e
          end
      end
    end
  end
  end

  private
  def self.find_set(code, name)
    MtgSet.find_by(code: code) || MtgSet.find_by(name: name)
  end
end
