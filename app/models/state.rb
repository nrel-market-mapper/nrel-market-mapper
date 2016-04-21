class State < ActiveRecord::Base
  has_many :summaries
  validates_presence_of :name
  validates_presence_of :abbr
  validates_uniqueness_of :name, case_sensitive: false
  validates_uniqueness_of :abbr, case_sensitive: false

  def data
    totals = summaries.find_by(year: "total")
    ordered_summaries = summaries.order("year")

    {
      years: ordered_summaries.pluck(:year)[0..-2],
      costs: ordered_summaries.pluck(:avg_cost)[0..-2].map(&:to_f),
      installs: ordered_summaries.pluck(:total_installs)[0..-2],
      capacities: ordered_summaries.pluck(:capacity)[0..-2].map(&:to_f),
      totals: {
        installs: totals.total_installs,
        capacity: totals.capacity,
        cost: totals.avg_cost
      }
    }
  end
end
