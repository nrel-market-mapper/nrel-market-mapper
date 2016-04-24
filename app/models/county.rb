class County < ActiveRecord::Base
  belongs_to :state
  has_many :zipcodes
  validates_presence_of :name
end
