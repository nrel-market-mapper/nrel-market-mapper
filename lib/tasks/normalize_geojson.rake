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
  puts "Normalized geojson for #{args[:abbr].upcase}"
end
