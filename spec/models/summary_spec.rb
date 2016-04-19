require 'rails_helper'

RSpec.describe Summary, type: :model do
  it { should belong_to :state }
end
