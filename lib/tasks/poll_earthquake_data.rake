  desc "Pull data every 15 minutes"
  task :pull_data => :environment do
    print "Pulling data"

	source = 'https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson'

	resp = Net::HTTP.get_response(URI.parse(source))
	data = resp.body
	data = JSON.parse(data, symbolize_keys: true)

	regions = []

	data["features"].each do |r|
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
			end
		end
		regions.push(region)
	end

	regions.each do |r|
		response = FIREBASE.push("regions", r)
		puts response.success? # => true
		puts response.code # => 200
		puts response.body # => { 'name' => "-INOQPH-aV_psbk3ZXEX" }
		puts response.raw_body # => '{"name":"-INOQPH-aV_psbk3ZXEX"}'
	end

  end
