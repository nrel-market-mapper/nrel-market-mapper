require "rails_helper"

RSpec.describe NrelService do
  context "#index" do
    it "returns all installations" do
      VCR.use_cassette("nrel_service#index") do
        service = NrelService.new
        result = service.index

        expect(result[:status]).to eq 200
        expect(result[:metadata][:resultset][:count]).to eq 483418
        expect(result[:result][0][:state]).to eq "AZ"
      end
    end

    it "return installations for CO" do
      VCR.use_cassette("nrel_service#index?state=CO") do
        service = NrelService.new
        result = service.index(state: "CO")

        expect(result[:status]).to eq 200
        expect(result[:metadata][:resultset][:count]).to eq 2601
        expect(result[:result][0][:zipcode]).to eq "81146"
      end
    end
  end

  context "#summaries" do
    it "returns summary data for US" do
      VCR.use_cassette("nrel_service#summaries") do
        service = NrelService.new
        result = service.summaries

        expect(result[:status]).to eq 200
        expect(result[:result][:avg_cost_cap_weight]).to eq 5.74
        expect(result[:result][:total_installs]).to eq 483418
      end
    end

    it "returns summary data for CA" do
      VCR.use_cassette("nrel_service#summaries?state=CA") do
        service = NrelService.new
        result = service.summaries(state: "CA")

        expect(result[:status]).to eq 200
        expect(result[:result][:avg_cost_cap_weight]).to eq 6.117
        expect(result[:result][:total_installs]).to eq 291518
      end
    end
  end

  context "#csv_index" do
    it "returns csv data" do
      VCR.use_cassette("nrel_service#csv_index?state=AL") do
        service = NrelService.new
        result = service.csv_index(state: "AL")

        expected = "Zipcode,State,Size (kW DC),Cost,Date Installed,Filters=state=AL"
        expect(result.split("\n").first).to eq expected
      end
    end
  end
end
