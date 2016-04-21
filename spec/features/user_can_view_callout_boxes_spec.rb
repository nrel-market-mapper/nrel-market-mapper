require "rails_helper"
Capybara.default_max_wait_time = 5

RSpec.feature "User can view callout boxes" do
  scenario "they see totals for US", js: true do
    VCR.use_cassette "callout_boxes_for_US" do
      visit root_path
      wait_for_ajax
save_and_open_page
      expect(page).to have_content "# of Installs"
      expect(page).to have_content "483418"
      expect(page).to have_content "Total Capacity"
      expect(page).to have_content "9171.96 MW"
      expect(page).to have_content "Avg Cost/yr"
      expect(page).to have_content "6.56 $/W"
    end
  end
end
