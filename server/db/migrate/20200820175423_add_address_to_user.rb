class AddAddressToUser < ActiveRecord::Migration[6.0]
  # Step: 2
  # rails g migration AddAddressToUser address:string
  def change
    add_column :users, :address, :string
  end
end
