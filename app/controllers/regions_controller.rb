class RegionsController < ApplicationController

	def index
	    @regions = Region.all
		json_response(@regions)

  
  # parsed_json = ActiveSupport::JSON.decode("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson")
  # parsed_json["results"].each do |longUrl, convertedUrl|
  		
  # 		site = Site.find_by_long_url(longUrl)
  # 		site.short_url = convertedUrl["shortUrl"]
  # 		site.save
	end

end

# {
# 	"type":"Feature",
# 	"properties":
# 		{ "mag":1.48,
# 			"place":"30km NE of Oakhurst, CA",
# 			"time":1518651199030,
# 			"updated":1518653350680,
# 			"tz":-480,
# 			"url":"https://earthquake.usgs.gov/earthquakes/eventpage/nc72969576",
# 			"detail":"https://earthquake.usgs.gov/earthquakes/feed/v1.0/detail/nc72969576.geojson",
# 			"felt":null,
# 			"cdi":null,
# 			"mmi":null,
# 			"alert":null,
# 			"status":"reviewed",
# 			"tsunami":0,
# 			"sig":34,
# 			"net":"nc",
# 			"code":"72969576",
# 			"ids":",nc72969576,",
# 			"sources":",nc,",
# 			"types":",focal-mechanism,geoserve,nearby-cities,origin,phase-data,scitech-link,",
# 			"nst":26,
# 			"dmin":0.1662,
# 			"rms":0.1,
# 			"gap":131,
# 			"magType":"md",
# 			"type":"earthquake",
# 			"title":"M 1.5 - 30km NE of Oakhurst, CA"
# 		},
# 	"geometry":{
# 		"type":"Point",
# 		"coordinates":[-119.3761667,37.4836667,9.76]},
# 		"id":"nc72969576"
# }

# region:

# 	name: properties["place"].split(" of ")[1]
# 	created_at: properties["time"]
# 	updated_at: properties["updated"]
# 	timezone: properties["tz"]
# 	mag: properties["mag"]






