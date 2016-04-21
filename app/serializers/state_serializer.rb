class StateSerializer < ActiveModel::Serializer
  attributes :years, :costs, :installs, :capacities, :totals

  def order_by_year
    object.summaries.order("year")
  end

  def years
    order_by_year.pluck(:year)[0..-2]
  end

  def costs
    order_by_year.pluck(:avg_cost)[0..-2].map(&:to_f)
  end

  def installs
    order_by_year.pluck(:total_installs)[0..-2]
  end

  def capacities
    order_by_year.pluck(:capacity)[0..-2].map(&:to_f)
  end

  def totals
    {
      installs: object.summaries.find_by(year: "total").total_installs.to_s,
      capacity: ((object.summaries.find_by(year: "total").capacity.to_f.round(2).to_s) + " MW"),
      cost: ((object.summaries.find_by(year: "total").avg_cost.to_f.round(2).to_s) + " $/W")
    }
  end
end
