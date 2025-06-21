namespace :sets do
  require "open-uri"
  require "zlib"

  desc "Seed Sets"
  task seed: :environment do
    url = "https://mtgjson.com/api/v5/SetList.json.gz"
    source = URI.open(url)
    gz = Zlib::GzipReader.new(source)
    json = JSON.parse(gz.read)
    MtgSet.delete_all


    json["data"].each do |set|
      MtgSet.create!(name: set["name"], code: set["parentCode"])
    end
    puts "Sets seeded successfully."
end
end
