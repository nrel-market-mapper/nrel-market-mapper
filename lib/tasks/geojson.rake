namespace :geojson do
  desc "Update the GeoJSON data with latest NREL data"
  task update_us: :environment do
    service = NrelService.new
    us = State.find_by(abbr: "US")
    geojson = JSON.parse(us.geojson).deep_symbolize_keys

    STATES.each_with_index do |(state, abbr), i|
      data = service.summaries(state: abbr)
      geojson[:features][i][:properties][:installs] = data[:result][:total_installs]
      puts "Updated #{state}"
    end

    us.update(geojson: geojson.to_json)
  end

  desc "Seed states with GeoJSON files"
  task seed_us: :environment do
    us_geojson = File.read(File.join(Rails.root, "lib", "assets", "geojson", "us.js")).gsub!(/\s+/, "")
    us = State.find_by(abbr: "US")
    us.update(geojson: us_geojson)
  end

  desc "Normalize county names in state geojson"
  task normalize_state: :environment do
    state_geojson = File.read(File.join(Rails.root, "lib", "assets", "geojson", "colorado.js"))
    parsed_json = JSON.parse(state_geojson).deep_symbolize_keys
    parsed_json[:features].each do |county|
      county[:properties][:name].chomp!(", CO")
    end

    File.open(File.join(Rails.root, "lib", "assets", "geojson", "colorado.js"), "w") do |file|
      file.write(parsed_json.to_json)
    end
  end

  desc "Add installs to state geojson for counties"
  task seed_county_installs: :environment do
    state_geojson = File.read(File.join(Rails.root, "lib", "assets", "geojson", "colorado.js"))
    parsed_json = JSON.parse(state_geojson).deep_symbolize_keys
    parsed_json[:features].each do |county|
      number_installs = State.find_by(abbr: "CO").counties.find_by(name: county[:properties][:name]).installs
      county[:properties][:installs] = number_installs
    end

    File.open(File.join(Rails.root, "lib", "assets", "geojson", "colorado.js"), "w") do |file|
      file.write(parsed_json.to_json)
    end
  end
end
