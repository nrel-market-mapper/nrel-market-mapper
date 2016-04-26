require "csv"

namespace :zipcode_installs do
  desc "Seed database with NREL install data for state zipcodes"
  task :summaries_seed, [:abbr] => [:environment] do |t, args|
    service = NrelService.new

    State.find_by(abbr: "#{args[:abbr].upcase}").zipcodes.each do |zipcode|
      response = service.summaries(zipcode: zipcode.number)
      installs = response[:result][:total_installs]
      zipcode.update(total_installs: installs)
      puts "Add #{installs} installs to #{zipcode.number}"
    end
  end

  desc "Seed database with NREL install data for state zipcodes with index"
  task :index_seed, [:abbr] => [:environment] do |t, args|

    file = "db/#{args[:abbr]}_install_index.csv"

    zipcodes = {}

    CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
      if zipcodes.key?(row[:zipcode])
        zipcodes[row[:zipcode]] += 1
      else
        zipcodes[row[:zipcode]] = 1
      end
    end

    state_abbr = args[:abbr].upcase
    state = State.find_by(abbr: "#{state_abbr}")
    invalid_zip_count = 0

    zipcodes.each do |zipcode, installs|
      zip = Zipcode.find_by(number: zipcode)
      if zip.nil?
        invalid_zip_count += installs
        puts "Zipcode #{zipcode} with #{installs} installs is not in database"
      else
        zip.update(total_installs: installs)
        puts "Add #{installs} installs to #{zipcode}"
      end
    end
    puts "There are #{invalid_zip_count} installations with invalid zipcodes"
  end
end
