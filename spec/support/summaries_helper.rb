module SummariesHelper
  def create_US_summaries
    state = State.create(name: "United States of America", abbr: "US")
    state.summaries.create(year: "total", avg_cost: 6.556, capacity: 9172.018, total_installs: 483418)
    state.summaries.create(year: "2016", avg_cost: 3.621, capacity: 2.4051, total_installs: 69)
    state.summaries.create(year: "2015", avg_cost: 3.42, capacity: 16.0842, total_installs: 353)
    state.summaries.create(year: "2014", avg_cost: 4.589, capacity: 1139.7637, total_installs: 77783)
    state.summaries.create(year: "2013", avg_cost: 4.772, capacity: 2268.3297, total_installs: 143640)
    state.summaries.create(year: "2012", avg_cost: 5.569, capacity: 2305.554, total_installs: 74526)
    state.summaries.create(year: "2011", avg_cost: 6.709, capacity: 1835.8102, total_installs: 70103)
    state.summaries.create(year: "2010", avg_cost: 7.237, capacity: 1148.9292, total_installs: 62881)
    state.summaries.create(year: "2009", avg_cost: 8.224, capacity: 608.2773, total_installs: 45077)
    state.summaries.create(year: "2008", avg_cost: 8.602, capacity: 414.8908, total_installs: 27908)
    state.summaries.create(year: "2007", avg_cost: 8.493, capacity: 298.8405, total_installs: 22046)
  end

  def create_CA_summaries
    state = State.create(name: "California", abbr: "CA")
    state.summaries.create(year: "total", avg_cost: 6.885, capacity: 3714.0115, total_installs: 287977)
    state.summaries.create(year: "2016", avg_cost: 4.495, capacity: 0.1513, total_installs: 2)
    state.summaries.create(year: "2015", avg_cost: 4.693, capacity: 0.2076, total_installs: 7)
    state.summaries.create(year: "2014", avg_cost: 4.724, capacity: 316.2762, total_installs: 25820)
    state.summaries.create(year: "2013", avg_cost: 4.957, capacity: 737.2442, total_installs: 65382)
    state.summaries.create(year: "2012", avg_cost: 5.782, capacity: 705.1962, total_installs: 40639)
    state.summaries.create(year: "2011", avg_cost: 6.856, capacity: 598.1639, total_installs: 46726)
    state.summaries.create(year: "2010", avg_cost: 7.385, capacity: 578.6522, total_installs: 39448)
    state.summaries.create(year: "2009", avg_cost: 8.255, capacity: 383.2033, total_installs: 30117)
    state.summaries.create(year: "2008", avg_cost: 8.559, capacity: 290.6396, total_installs: 21316)
    state.summaries.create(year: "2007", avg_cost: 8.359, capacity: 234.4466, total_installs: 17873)
  end
end
