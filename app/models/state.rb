class State < ActiveRecord::Base
  has_many :summaries
  validates_presence_of :name
  validates_presence_of :abbr
  validates_uniqueness_of :name, case_sensitive: false
  validates_uniqueness_of :abbr, case_sensitive: false
end
