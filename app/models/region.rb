class Region < ApplicationRecord
	scope :largest_magnitude, -> { order('magnitude desc') }
	scope :days, ->(days) { past_days(days) }
	scope :county_name, -> (name) {where("name like ?", "%#{name}%")}

	def self.past_days(days)
		where(occured_at: (days.to_i).days.ago..Date.today)
	end

	def self.process_data(regions, limit)
		regions_grouped = regions.group("name")
		regions_count = regions_grouped.count
		regions_total_magnitude = regions_grouped.sum("magnitude")
		data = Array.new

		regions_grouped.each do |r|
			total_magnitude = regions_total_magnitude[r["name"]].round(2)
			total_earthquake_count = regions_count[r["name"]]
			region_hash = Hash.new
			region_hash[total_magnitude] = {:name => r["name"], :count => total_earthquake_count }
			data << region_hash
		end

		sorted_by_magnitude = (data.sort_by {|region| region.keys[0]}).reverse

		data.clear
		sorted_by_magnitude.each do |region|
			region_info = Hash.new
			region_info["name"] = region.first.last[:name]
			region_info["total_magnitude"] = region.first.first
			region_info["earthquake_count"] = region.first.last[:count]
			data << region_info
		end

		return data[0..limit-1]
	end

	def energy
		(11.8 + 1.5 * self.magnitude)
	end

end
