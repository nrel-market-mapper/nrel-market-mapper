class DatabaseLoader
  def self.seed
    service = NrelService.new
    data = service.summaries(state: "CA", mindate: "1262304000", maxdate: "1293839999")

    state = State.create(abbr: "CA", name: "California")
    state.summaries.create(year: "2010",
                        avg_cost: data[:result][:avg_cost_pw],
                        capacity: data[:result][:total_capacity],
                        total_installs: data[:result][:total_installs])
  end
end
