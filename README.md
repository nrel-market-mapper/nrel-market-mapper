## Synopsis

The [NREL Market Mapper](http://nrel-market-mapper.herokuapp.com/) is an application
that visualizes the current state of the US solar photovoltaic market. It includes
installation data for both state and county level along with charts showing the number of installs,
total capacity and average cost over a ten year range.

## Code Example

One of the main focuses for this application was performance. Instead of directly
hitting NREL's API for every call, we decided to create our own internal API. The
application uses rake tasks along with a crontab to hit the NREL API nightly to
update the application's database with the most recent solar installation data.

Here is an example rake task that hits the NREL API and updates the application
database:

```ruby
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
end
```
The `NrelService.new` creates a PORO that allows us to easily make API calls to
NREL's endpoints within the application. Two of the endpoints that we can hit are
the index endpoint and summaries endpoint. In the case below, we are hitting the summaries
endpoint, passing in a hash for the minimum date and maximum date which represent
the start and end of 2016.

The code:

```ruby
service.summaries(mindate: YEARS["2016"][:min], maxdate: YEARS["2016"][:max])
```

Evaluates to the endpoint:

```
https://developer.nrel.gov/api/solar/open_pv/installs/summaries?api_key=YOUR_API_KEY&mindate=1451606400&maxdate=1483228799
```

Our internal API returns the summary data for the US as a whole and for each state. Our
API returns only the specific data needed to create the map and charts, cutting down
the amount of data that is sent to the front-end.

Here is the summaries endpoint for accessing the US data:

```
nrel-market-mapper.herokuapp.com/api/v1/summaries
```

And here is an example of hitting the summaries endpoint for Colorado:

```
nrel-market-mapper.herokuapp.com/api/v1/summaries/find?state=CO
```

## Motivation

NREL previously created their Market Mapper application in 2009 using the now
defunct FlexMapper. This caused NREL to pull the Market Mapper from the Open PV
visualization gallery because the application was not able to be maintained using
the original technologies. A complete overhaul was needed using modern technologies.

The motivation was to recreate the Market Mapper with a focus on performance and mobile-first
design since the majority of users now access websites through their mobile devices. This meant
implementing responsive design to account for the variety of device sizes.

## Example Usage

Mobile usage:

![nrel mobile](/app/assets/images/nrel-mobile.gif)

Desktop usage:

![nrel desktop](/app/assets/images/nrel-desktop.gif)

## Contributors

Kimiko Kano - [github](https://github.com/ksk5280)
Julian Feliciano - [github](https://github.com/julsfelic)
