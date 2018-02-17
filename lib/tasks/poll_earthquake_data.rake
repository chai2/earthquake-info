  desc "Pull data every 15 minutes"
  task :pull_data => :environment do
    print "Pulling data"

	source = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'

	resp = Net::HTTP.get_response(URI.parse(source))
	data = resp.body
	data = JSON.parse(data, symbolize_keys: true)

	latest_region = Region.order(occured_at: :desc).first

	regions = []

	data["features"].each do |r|
		if (latest_region.nil? || (Time.at((r["properties"]["time"])/1000) > latest_region["occured_at"]))
			region = Hash.new
			r["properties"].each do |p|
					region[:place] = p[1].partition(" of ").last if p[0] == "place"
					region[:mag] = p[1] if p[0] == "mag"
					region[:occured_at] = Time.at(p[1]/1000) if p[0] == "time"
					region[:updated_at] = Time.at(p[1]/1000) if p[0] == "updated"
					region[:timezone] = p[1] if p[0] == "tz"				
			end
			r["geometry"].each do |g|
				if g[0] == "coordinates"
					region[:longitude] = g[1][0] 
					region[:latitude] = g[1][1]
					region[:depth] = g[1][2]
						location = "#{region[:latitude]}, #{region[:longitude]}"
						geo_location = Geocoder.search(location).first
						puts geo_location
					  	if geo_location.present? && geo_location.address_components.size > 1
					    	geo_location.address_components.each do |component|
					    		if component["types"][0] == "administrative_area_level_2"
					    			region[:name] = component["long_name"]
					    			puts region[:name]
					    		end
							end
					  	end
				end
			end
			regions.push(region)
		end

	end

	regions.each do |r|
		if Region.find_by(occured_at: r[:occured_at], name: r[:place]).nil?
				region = Region.create(
				occured_at: r[:occured_at],
	          	place: r[:place],
				name: r[:name], 
				magnitude: r[:mag],
				timezone: r[:time],
				created_at: r[:created_at],
				updated_at: r[:updated_at],
				longitude: r[:longitude],
				latitude: r[:latitude],
				depth: r[:depth]
			)
		end
		puts "Created region #{r}"
	end

  end
