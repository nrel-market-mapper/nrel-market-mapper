require 'rails_helper'

RSpec.describe County, type: :model do
  it { should belong_to :state }
  it { should have_many :zipcodes }
  it { should validate_presence_of :name }
end
