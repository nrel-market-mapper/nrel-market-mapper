class Zipcode < ActiveRecord::Base
  belongs_to :county
  validates_presence_of :number
  validates_uniqueness_of :number
end
