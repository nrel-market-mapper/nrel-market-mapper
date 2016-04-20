class State < ActiveRecord::Base
  has_many :summaries
  validates_presence_of :name
  validates_presence_of :abbr
  validates_uniqueness_of :name, case_sensitive: false
  validates_uniqueness_of :abbr, case_sensitive: false

  def data
    {
      years: summaries.order("year").pluck(:year)[0..-2],
      costs: summaries.order("year").pluck(:avg_cost)[0..-2].map(&:to_f),
      installs: summaries.order("year").pluck(:total_installs)[0..-2],
      capacities: summaries.order("year").pluck(:capacity)[0..-2].map(&:to_f)
    }
  end
end
