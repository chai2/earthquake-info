class CreateRegions < ActiveRecord::Migration[5.1]
  def change
    create_table :regions do |t|
      t.string	:name
      t.float :magnitude
      t.datetime :occured_at
      t.string :timezone
      t.float :longitude
      t.float :latitude
      t.float :depth
      t.timestamps
    end
  end
end
