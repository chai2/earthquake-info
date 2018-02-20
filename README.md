# Instructions to run Earthquake Information 

This README would normally document whatever steps are necessary to get the
application up and running.

* Step 1: Clone the project `git clone git@github.com:chai2/earthquake-info.git`

* Step 2: cd earthquake-info

* Step 3: Install required gems by using `bundle install`

* Step 4: Create database and run migrations. We are using sqlite for basic setup `rake db:create` then `rake db:migrate`

* Step 5: Fetch initial data from [Data Source](http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson) using `rake pull_data` (This will fetch the data and gets county information from Geocoder using Google maps api)

* Step 6: Pull data from data source every 15 mins using `whenever --update-crontab` . This commands writes the cronjob to run the rake task to pull data every 15 mins. 

* Step 7: Start the server using `rails s`

* Step 8: Visit the localhost `http://localhost:3000/` returns 10 largest regions with total_magnitude past 30 days

* Step 9: Make a sample request to get 20 results past 10 days using `http://localhost:3000/regions?count=20&days=10`

Gems used:

* Whenever gem is used to update cronjobs
* rails_param gem validates the request parameters and returns an exception
