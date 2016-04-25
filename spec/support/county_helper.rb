module CountyHelper
  def create_county_with_10_installs
    county = County.create(name: "Denver County")
    county.zipcodes.create(number: "80230", total_installs: 2)
    county.zipcodes.create(number: "80231", total_installs: 3)
    county.zipcodes.create(number: "80232", total_installs: 5)
    county
  end
end

RSpec.configure do |c|
  c.include CountyHelper, type: :model
end
