class State < ActiveRecord::Base
  has_many :summaries
  validates_presence_of :name
  validates_presence_of :abbr
  validates_uniqueness_of :name, case_sensitive: false
  validates_uniqueness_of :abbr, case_sensitive: false

  def data
    {
      years: summaries.pluck(:year)[0..9].reverse,
      cost: summaries.pluck(:avg_cost).map(&:to_f)[0..9].reverse,
      installs: summaries.pluck(:total_installs)[0..9].reverse,
      capacity: summaries.pluck(:capacity).map(&:to_f)[0..9].reverse
    }
  end
end
