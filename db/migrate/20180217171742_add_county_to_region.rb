class AddCountyToRegion < ActiveRecord::Migration[5.1]
  def change
  	add_column :regions, :place, :string, :after => :name
  end
end
