require "csv"

desc "Add county installs to geojson for all states!"
task seed_all_states: :environment do |t, args|
  STATES.each do |abbr|
    Rake::Task[:index_seed].invoke(abbr[1].downcase)
    # reenable allows you to invoke this task again next time through the loop
    Rake::Task[:index_seed].reenable
    Rake::Task[:seed_county_installs].invoke(abbr[1].downcase)
    Rake::Task[:seed_county_installs].reenable
    Rake::Task[:seed_state].invoke(abbr[1].downcase)
    Rake::Task[:seed_state].reenable
  end
end

desc "Add county installs to geojson for one state"
task :seed_state_geojson, [:abbr] => [:environment] do |t, args|
  Rake::Task[:index_seed].invoke(args[:abbr])
  Rake::Task[:seed_county_installs].invoke(args[:abbr])
  Rake::Task[:seed_state].invoke(args[:abbr])
end

desc "Seed database with NREL install data for state zipcodes from CSV"
task :index_seed, [:abbr] => [:environment] do |t, args|

  file = "db/data/#{args[:abbr]}_install_index.csv"
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

desc "Add installs to state geojson for counties"
task :seed_county_installs, [:abbr] => [:environment] do |t, args|
  state_geojson = File.read(File.join(Rails.root, "lib", "assets", "geojson", "#{args[:abbr]}.js"))
  parsed_json = JSON.parse(state_geojson).deep_symbolize_keys
  parsed_json[:features].each do |county_geojson|
    county_name = county_geojson[:properties][:name]
    county = State.find_by(abbr: "#{args[:abbr].upcase}").counties.find_by(name: county_name)
    if county
      number_installs = county.installs
      county_geojson[:properties][:installs] = number_installs
    else
      puts "#{county_name} does not exist in database"
    end
  end

  File.open(File.join(Rails.root, "lib", "assets", "geojson", "#{args[:abbr]}.js"), "w") do |file|
    file.write(parsed_json.to_json)
  end
  puts "Added county installs to geojson for #{args[:abbr].upcase}"
end

desc "Seed states with GeoJSON files"
task :seed_state, [:abbr] => [:environment] do |t, args|
  geojson = File.read(File.join(Rails.root, "lib", "assets", "geojson", "#{args[:abbr]}.js"))
  state = State.find_by(abbr: "#{args[:abbr].upcase}")
  state.update(geojson: geojson)

  puts "Seed #{args[:abbr].upcase} with geojson"
end
