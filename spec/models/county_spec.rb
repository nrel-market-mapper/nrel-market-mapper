require 'rails_helper'

RSpec.describe County, type: :model do
  it { should belong_to :state }
  it { should have_many :zipcodes }
  it { should validate_presence_of :name }
end

RSpec.describe '#installs' do
  it "returns number of installs for a county" do
    county = create_county_with_10_installs

    expect(county.installs).to eq 10
  end
end
