require "rails_helper"

RSpec.feature "User can see states" do
  scenario "they see map for a specific state" do
    cali = State.create(name: "California", abbr: "CA")
    colo = State.create(name: "Colorado", abbr: "CO")

    visit root_path

    click_on "States"
    select "California", from: "states"

    expect(page).to have_content "# of Installs"
    expect(page).to have_content "Total Capacity"
    expect(page).to have_content "Avg Cost"
  end
end
