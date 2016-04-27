require "csv"

namespace :state_lat_long do
  desc "Add latitude and longitude to states from csv"
  task seed: :environment do
    CSV.foreach("db/data/state_latlon.csv", headers: true, header_converters: :symbol) do |row|
      State.find_by(abbr: row[:state]).update(lat: row[:latitude], long: row[:longitude])
      puts "Updated #{row[:state]}"
    end
  end
end
