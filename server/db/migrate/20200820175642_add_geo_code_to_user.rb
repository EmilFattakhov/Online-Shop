class AddGeoCodeToUser < ActiveRecord::Migration[6.0]
  # Step: 2
  # rails g migration AddGeoCodeToUser latitude:float longitude:float
  def change
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
  end
end
