require 'rails_helper'

RSpec.describe Zipcode, type: :model do
  it { should belong_to :county }
  it { should validate_presence_of :number }
  it { should validate_uniqueness_of :number }
end
