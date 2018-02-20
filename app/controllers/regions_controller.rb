class RegionsController < ApplicationController

  before_action :get_regions

	def index
    begin 
      param! :name, String
      param! :days, Integer, default: 30
      param! :count, Integer, default: 10

      @regions = @regions.county_name(params["name"]) if params[:name].present?      
      @regions = @regions.past_days(params[:days]) if params[:days].present?

      query_data = Region.process_data(@regions, params["count"])
      json_response(query_data)

    rescue InvalidParameterError => e
      json_response("Invalid parameter values \nCount: #{params[:count]} & Days: #{params[:days]} \n#{e}")
    end
	end

  private

  def get_regions
    @regions = Region.largest_magnitude
  end

end