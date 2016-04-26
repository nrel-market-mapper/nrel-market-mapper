require "csv"

namespace :county_zipcode do
  desc "Seed database with counties and zipcodes from csv"
  task csv_seed: :environment do
    CSV.foreach("db/zip_code_database.csv", headers: :true, header_converters: :symbol) do |row|
      state = State.find_by(abbr: row[:state])
      if state && row[:county]
        county = state.counties.find_or_create_by(name: row[:county])
        puts "Created county #{county.name}"
        zipcode = county.zipcodes.find_or_create_by(number: row[:zip])
        puts "Created zipcode #{row[:zip]}"
      end
    end
  end
end
