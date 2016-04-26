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

  desc "Seed US with GeoJSON files"
  task seed_us: :environment do
    us_geojson = File.read(File.join(Rails.root, "lib", "assets", "geojson", "us.js")).gsub!(/\s+/, "")
    us = State.find_by(abbr: "US")
    us.update(geojson: us_geojson)
  end

  desc "Seed states with GeoJSON files"
  task :seed_state, [:abbr] => [:environment] do |t, args|
    geojson = File.read(File.join(Rails.root, "lib", "assets", "geojson", "#{args[:abbr]}.js"))
    state = State.find_by(abbr: "#{args[:abbr].upcase}")
    state.update(geojson: geojson)
  end

  desc "Normalize county names in state geojson"
  task :normalize_state, [:abbr] => [:environment] do |t, args|
    state_geojson = File.read(File.join(Rails.root, "lib", "assets", "geojson", "#{args[:abbr]}.js"))
    parsed_json = JSON.parse(state_geojson).deep_symbolize_keys
    parsed_json[:features].each do |county|
      county[:properties][:name].chomp!(", #{args[:abbr].upcase}")
    end

    File.open(File.join(Rails.root, "lib", "assets", "geojson", "#{args[:abbr]}.js"), "w") do |file|
      file.write(parsed_json.to_json)
    end
  end
end
