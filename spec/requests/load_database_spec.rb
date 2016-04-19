require "rails_helper"

RSpec.describe "Loading NREL API into database" do
  it "loads data into the database" do
    VCR.use_cassette "loading_database" do
      get "/states/new"

      cali = State.find_by(abbr: "CA")

      expect(cali.name).to eq "California"
      expect(cali.summaries).to_not be_empty

      cali_2010 = cali.summaries.find_by(year: "2010")

      expect(cali_2010.avg_cost).to eq 7.385
      expect(cali_2010.total_installs).to eq 39448
    end
  end
end
