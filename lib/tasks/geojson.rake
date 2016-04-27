namespace :geojson do
  desc "Update the US GeoJSON data with latest NREL data"
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

  desc "Seed US object with GeoJSON files"
  task seed_us: :environment do
    us_geojson = File.read(File.join(Rails.root, "lib", "assets", "geojson", "us.js")).gsub!(/\s+/, "")
    us = State.find_by(abbr: "US")
    us.update(geojson: us_geojson)
  end
end
