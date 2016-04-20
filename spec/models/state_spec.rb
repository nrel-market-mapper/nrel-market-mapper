require 'rails_helper'

RSpec.describe State, type: :model do
  it { should have_many :summaries }
  it { should validate_presence_of :name }
  it { should validate_presence_of :abbr }
  it { should validate_uniqueness_of(:name).case_insensitive }
  it { should validate_uniqueness_of(:abbr).case_insensitive }
end
