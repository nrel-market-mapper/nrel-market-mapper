YEARS = {
  "2007"  => { min: "1167609600", max: "1199145599" },
  "2008"  => { min: "1199145600", max: "1230767999" },
  "2009"  => { min: "1230768000", max: "1262303999" },
  "2010"  => { min: "1262304000", max: "1293839999" },
  "2011"  => { min: "1293840000", max: "1325375999" },
  "2012"  => { min: "1325376000", max: "1356998399" },
  "2013"  => { min: "1356998400", max: "1420070399" },
  "2014"  => { min: "1388534400", max: "1420070399" },
  "2015"  => { min: "1420070400", max: "1451606399" },
  "2016"  => { min: "1451606400", max: "1483228799" }
}

STATES = {
  "Alabama"        => "AL",
  "Alaska"         => "AK",
  "Arizona"        => "AZ",
  "Arkansas"       => "AR",
  "California"     => "CA",
  "Colorado"       => "CO",
  "Connecticut"    => "CT",
  "Delaware"       => "DE",
  "Florida"        => "FL",
  "Georgia"        => "GA",
  "Hawaii"         => "HI",
  "Idaho"          => "ID",
  "Illinois"       => "IL",
  "Indiana"        => "IN",
  "Iowa"           => "IA",
  "Kansas"         => "KS",
  "Kentucky"       => "KY",
  "Louisiana"      => "LA",
  "Maine"          => "ME",
  "Maryland"       => "MD",
  "Massachusetts"  => "MA",
  "Michigan"       => "MI",
  "Minnesota"      => "MN",
  "Mississippi"    => "MS",
  "Missouri"       => "MO",
  "Montana"        => "MT",
  "Nebraska"       => "NE",
  "Nevada"         => "NV",
  "New Hampshire"  => "NH",
  "New Jersey"     => "NJ",
  "New Mexico"     => "NM",
  "New York"       => "NY",
  "North Carolina" => "NC",
  "North Dakota"   => "ND",
  "Ohio"           => "OH",
  "Oklahoma"       => "OK",
  "Oregon"         => "OR",
  "Pennsylvania"   => "PA",
  "Rhode Island"   => "RI",
  "South Carolina" => "SC",
  "South Dakota"   => "SD",
  "Tennessee"      => "TN",
  "Texas"          => "TX",
  "Utah"           => "UT",
  "Vermont"        => "VT",
  "Virginia"       => "VA",
  "Washington"     => "WA",
  "West Virginia"  => "WV",
  "Wisconsin"      => "WI",
  "Wyoming"        => "WY"
}

namespace :nrel_api_to_database do
  desc "Seed the database with NREL API data"
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

  desc "updates the NREL datebase"
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
