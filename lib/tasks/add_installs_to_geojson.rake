namespace :geojson do
  desc "Add installs to state geojson for counties"
  task :seed_county_installs, [:abbr] => [:environment] do |t, args|
    state_geojson = File.read(File.join(Rails.root, "lib", "assets", "geojson", "#{args[:abbr]}.js"))
    parsed_json = JSON.parse(state_geojson).deep_symbolize_keys
    parsed_json[:features].each do |county|
      number_installs = State.find_by(abbr: "#{args[:abbr].upcase}").counties.find_by(name: county[:properties][:name]).installs
      county[:properties][:installs] = number_installs
    end

    File.open(File.join(Rails.root, "lib", "assets", "geojson", "#{args[:abbr]}.js"), "w") do |file|
      file.write(parsed_json.to_json)
    end
  end
end
