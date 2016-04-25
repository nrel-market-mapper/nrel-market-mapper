require "rails_helper"

RSpec.feature "User can view callout boxes", :js => true do
  scenario "they see totals for US" do
    VCR.use_cassette "callout_boxes_for_US" do
      state = State.create(abbr: "US", name: "United States of America")
      state.summaries.create(avg_cost: 6.56, capacity: 9171.96, total_installs: 483418)
      File.read(File.join(Rails.root, "app", ""))
binding.pry
      # driver = Selenium::WebDriver.for :firefox
      # driver.navigate.to "http://localhost:3000/"
      visit root_path
      click_on "USA"
      # click_on "States"
      # find("#states").find(:xpath, "option[CA]").select_option
      # select "CO", from: "states"
      # wait = Selenium::WebDriver::Wait.new(:timeout => 5) # seconds
      # wait.until { driver.find_element(:id => "total_installs") }
      wait_for_ajax
      sleep(5)
      # save_and_open_page

      # wait_until { page.has_no_content?("n/a") }

      # page.should have_selector("#total_installs", :text => "n/a")
      # wait_until { page.should have_no_content("n/a") }
      # page.should have_no_content("n/a")

      # expect(page).to have_selector("#total_installs", visible: true)
      expect(page).to have_content "# of Installs"

      # expect(find("#total_installs")).to have_content "483418"
      expect(page).to have_content "483418"
      expect(page).to have_content "Total Capacity"
      # expect(page).to have_content "9171.96 MW"
      expect(page).to have_content "Avg Cost/yr"
      # expect(page).to have_content "6.56 $/W"
    end
  end
end
