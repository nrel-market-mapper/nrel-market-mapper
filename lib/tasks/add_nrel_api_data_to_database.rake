namespace :nrel_api_to_database do
  desc "Seed the database with NREL API solar data from summaries"
  task seed: :environment do
    service = NrelService.new
    data = service.summaries

    usa = State.create(abbr: "US", name: "United States of America")
    usa.summaries.create(year: "total",
    avg_cost: data[:result][:avg_cost_pw],
    capacity: data[:result][:total_capacity],
    total_installs: data[:result][:total_installs])

    puts "Added total NREL data for the US"

    YEARS.each do |year, year_range|
      service = NrelService.new
      data = service.summaries(mindate: year_range[:min], maxdate: year_range[:max])

      usa.summaries.create(year: year,
      avg_cost: data[:result][:avg_cost_pw],
      capacity: data[:result][:total_capacity],
      total_installs: data[:result][:total_installs])

      puts "Added #{year} NREL data for the US"
    end

    STATES.each do |state, abbr|
      service = NrelService.new
      data = service.summaries(state: abbr)

      current_state = State.create(abbr: abbr, name: state)
      current_state.summaries.create(year: "total",
      avg_cost: data[:result][:avg_cost_pw],
      capacity: data[:result][:total_capacity],
      total_installs: data[:result][:total_installs])

      puts "Added total NREL data for #{state}"

      YEARS.each do |year, year_range|
        service = NrelService.new
        data = service.summaries(state: abbr, mindate: year_range[:min], maxdate: year_range[:max])

        current_state.summaries.create(year: year,
        avg_cost: data[:result][:avg_cost_pw],
        capacity: data[:result][:total_capacity],
        total_installs: data[:result][:total_installs])

        puts "Added #{year} NREL data for #{state}"
      end
    end
  end

  desc "Updates the NREL datebase if there is new solar data"
  task update: :environment do

    us = State.find_by(abbr: "US")

    service = NrelService.new
    data = service.summaries(mindate: YEARS["2016"][:min], maxdate: YEARS["2016"][:max])
    summary_2016 = us.summaries.find_by(year: "2016")
    summary_2016.update(avg_cost: data[:result][:avg_cost_pw],
                        capacity: data[:result][:total_capacity],
                        total_installs: data[:result][:total_installs])

    puts "Updated 2016 NREL data for US"

    data = service.summaries
    summary_total = us.summaries.find_by(year: "total")
    summary_total.update(avg_cost: data[:result][:avg_cost_pw],
                        capacity: data[:result][:total_capacity],
                        total_installs: data[:result][:total_installs])

    puts "Updated total NREL data for US"

    STATES.each do |state, abbr|
      current_state = State.find_by(abbr: abbr)

      service = NrelService.new
      data = service.summaries(state: abbr, mindate: YEARS["2016"][:min], maxdate: YEARS["2016"][:max])
      summary_2016 = current_state.summaries.find_by(year: "2016")
      summary_2016.update(avg_cost: data[:result][:avg_cost_pw],
                          capacity: data[:result][:total_capacity],
                          total_installs: data[:result][:total_installs])

      puts "Updated 2016 NREL data for #{state}"

      data = service.summaries(state: abbr)
      summary_total = current_state.summaries.find_by(year: "total")
      summary_total.update(avg_cost: data[:result][:avg_cost_pw],
                          capacity: data[:result][:total_capacity],
                          total_installs: data[:result][:total_installs])

      puts "Updated total NREL data for #{state}"
    end
  end
end
