namespace :languages do
  desc "Seed Languages"
  task seed: :environment do
    Language.delete_all
    # In addition to English, Magic: The Gathering has been printed in French, German, Italian, Portuguese, Spanish, Russian, Korean, Japanese, Simplified Chinese and Traditional Chinese.
    languages = [
      { name: "English", code: "en" },
      { name: "French", code: "fr" },
      { name: "German", code: "de" },
      { name: "Italian", code: "it" },
      { name: "Portuguese", code: "pt" },
      { name: "Spanish", code: "es" },
      { name: "Russian", code: "ru" },
      { name: "Korean", code: "ko" },
      { name: "Japanese", code: "ja" },
      { name: "Simplified Chinese", code: "zh-Hans" },
      { name: "Traditional Chinese", code: "zh-Hant" }
    ]
    languages.each do |language|
      Language.create!(language)
    end
  end
end
