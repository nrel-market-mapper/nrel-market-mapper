class StateSerializer < ActiveModel::Serializer
  include ActionView::Helpers::NumberHelper
  attributes :years, :costs, :installs, :capacities, :totals, :geojson, :lat_long

  def summaries
    @summaries ||= object.summaries
  end

  def order_by_year
    summaries.order("year")
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

  def lat_long
    [object.lat, object.long]
  end

  def totals
    {
      installs: number_with_delimiter(summaries.find_by(year: "total").total_installs),
      capacity: ((summaries.find_by(year: "total").capacity.to_f.round(2).to_s) + " MW"),
      cost: ((summaries.find_by(year: "total").avg_cost.to_f.round(2).to_s) + " $/W")
    }
  end
end
