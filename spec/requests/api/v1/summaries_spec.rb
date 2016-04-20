require "rails_helper"

RSpec.describe "GET /api/v1/summaries" do
  it "returns a list of PV data for the US by year" do
    get "/api/v1/summaries"

    json = JSON.parse(response.body)

    expect(response).to be_success

    expected = {
      "years" =>    ["2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016"],
      "cost" =>     [8.493, 8.602, 8.224, 7.237, 6.709, 5.569, 4.772, 4.589, 3.42, 3.621],
      "installs" => [22046, 27908, 45077, 62881, 70103, 74526, 143640, 77783, 353, 69],
      "capacity" => [298.8405, 414.8908, 608.2773, 1148.9292, 1835.8102, 2305.554, 2268.3297, 1139.7637, 16.0842, 2.4051]
    }

    expect(json).to eq expected
  end
end
