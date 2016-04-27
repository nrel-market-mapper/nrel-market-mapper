require "rails_helper"

RSpec.feature "User can view home page" do
  scenario "they see callout boxes", js: true do

    state = State.create(abbr: "US", name: "United States of America")
    state.summaries.create(avg_cost: 6.56, capacity: 9171.96, total_installs: 483418)
    us_geojson = File.read(File.join(Rails.root, "lib", "assets", "geojson", "us.js")).gsub!(/\s+/, "")
    state.update(geojson: us_geojson)

    visit root_path

    expect(page).to have_content "# of Installs"
    # expect(page).to have_content "483418"
    expect(page).to have_content "Total Capacity"
    # expect(page).to have_content "9171.96 MW"
    expect(page).to have_content "Avg Cost"
    # expect(page).to have_content "6.56 $/W"
  end
end
