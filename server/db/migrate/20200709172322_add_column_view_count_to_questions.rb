class AddColumnViewCountToQuestions < ActiveRecord::Migration[6.0]
  # To generate a migration file do:
  # rails g migration <migration-name>
  def change
    # Use the add_column method to add columns do
    # a table. It's arguments are (in order):
    #  - the table's name as a symbol 
    #  - the new column's name as symbol
    #  - the type of the new column
    add_column :questions, :view_count, :integer
  end
end
