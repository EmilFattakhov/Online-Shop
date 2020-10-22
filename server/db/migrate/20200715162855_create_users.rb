class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email #, index: { unique: true }
      # Add an index to columns that you query often
      # It will improve the performance of the query 
      # Significantly as the db grows in size.
      # An index achieves this by creating an
      # ordered list (a bindary tree technically)
      # that gives the db a faster way to search for 
      # values in that column.
      t.string :password_digest

      t.timestamps
    end
    add_index :users, :email
  end
end
