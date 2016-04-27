desc "Write csv from index of installs"
task :write_csv, [:abbr] => [:environment] do |t, args|
  service = NrelService.new
  text = service.csv_index(state: args[:abbr].upcase)
  File.open("db/#{args[:abbr]}_install_index.csv", 'w') do |f|
    f.write text
  end
end
