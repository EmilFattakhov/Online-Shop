class AddIndexesToQuestions < ActiveRecord::Migration[6.0]
  def change
    # Indexes will performance to our read queries and on the other 
    # hand, the right queries will be slightly slower and they increase
    # the capacity of your db store
    # to read more about indexes checkout:
    # https://apidock.com/rails/ActiveRecord/ConnectionAdapters/SchemaStatements/add_index
    add_index(:questions, :title)
  end
end
