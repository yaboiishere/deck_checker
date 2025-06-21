namespace :currency do
  desc "Seed Currency"
    task seed: :environment do
      Currency.delete_all
      currencies = [
        { name: "United States Dollar", code: "USD", symbol: "$" },
        { name: "Euro", code: "EUR", symbol: "€" },
        { name: "Bulgarian Lev", code: "BGN", symbol: "лв" }
      ]
      currencies.each do |currency|
        Currency.create!(currency)
      end
  end
end
