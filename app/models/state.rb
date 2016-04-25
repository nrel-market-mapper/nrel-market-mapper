class State < ActiveRecord::Base
  has_many :summaries
  has_many :counties
  has_many :zipcodes, through: :counties

  validates_presence_of :name
  validates_presence_of :abbr
  validates_presence_of :zoom
  validates_uniqueness_of :name, case_sensitive: false
  validates_uniqueness_of :abbr, case_sensitive: false

  serialize :geojson, JSON

  def max_county_installs
    counties.joins(:zipcodes).group(:name).sum(:total_installs).values.max
  end
end
