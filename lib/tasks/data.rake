namespace :data do
desc "Seed Data"
  task seed: :environment do
    Rake::Task["languages:seed"].invoke
    Rake::Task["currency:seed"].invoke
    Rake::Task["sets:seed"].invoke
  end
end
