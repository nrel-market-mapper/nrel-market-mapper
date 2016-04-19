require "rails_helper"

RSpec.feature "User can view navbar" do
  scenario "they see the navbar" do
    visit root_path

    expect(page).to have_content("USA")
    expect(page).to have_content("State")
  end
end
