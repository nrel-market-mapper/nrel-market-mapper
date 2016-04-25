require "rails_helper"

RSpec.describe "GET /api/v1/summaries" do
  it "returns a list of PV data for the US by year" do
    create_US_summaries
    get "/api/v1/summaries"
    json = JSON.parse(response.body)

    expected = {
      "years"      => ["2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016"],
      "costs"      => [8.493, 8.602, 8.224, 7.237, 6.709, 5.569, 4.772, 4.589, 3.42, 3.621],
      "installs"   => [22046, 27908, 45077, 62881, 70103, 74526, 143640, 77783, 353, 69],
      "capacities" => [298.8405, 414.8908, 608.2773, 1148.9292, 1835.8102, 2305.554, 2268.3297, 1139.7637, 16.0842, 2.4051],
      "totals"     => { "installs"=>"483,418", "capacity"=>"9172.02 MW", "cost"=>"6.56 $/W" }
    }

    expect(response).to be_success
    expect(json["years"]).to eq(expected["years"])
    expect(json["costs"]).to eq(expected["costs"])
    expect(json["installs"]).to eq(expected["installs"])
    expect(json["capacities"]).to eq(expected["capacities"])
    expect(json["totals"]).to eq(expected["totals"])
  end
end

RSpec.describe "GET /api/v1/summaries?state=CA" do
  it "returns a list of PV data for a specific state by year" do
    create_CA_summaries
    get "/api/v1/summaries/find?state=CA"

    json = JSON.parse(response.body)

    expected = {
      "years"      => ["2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016"],
      "costs"      => [8.359, 8.559, 8.255, 7.385, 6.856, 5.782, 4.957, 4.724, 4.693, 4.495],
      "installs"   => [17873, 21316, 30117, 39448, 46726, 40639, 65382, 25820, 7, 2],
      "capacities" => [234.4466, 290.6396, 383.2033, 578.6522, 598.1639, 705.1962, 737.2442, 316.2762, 0.2076, 0.1513],
      "totals"     => { "installs"=>"287,977", "capacity"=>"3714.01 MW", "cost"=>"6.89 $/W" }
    }

    expect(response).to be_success
    expect(json["years"]).to eq(expected["years"])
    expect(json["costs"]).to eq(expected["costs"])
    expect(json["installs"]).to eq(expected["installs"])
    expect(json["capacities"]).to eq(expected["capacities"])
    expect(json["totals"]).to eq(expected["totals"])
  end
end
