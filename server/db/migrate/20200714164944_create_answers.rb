class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.text :body
      t.references :question, null: false, foreign_key: true

      # The above creates a 'question_id' column
      # of type 'big_int'. It also sets a foreign_key
      # constraint to enforce the association to the 
      # questions table at the db level. The question_id
      # will refer to the id of the question in the 
      # questions table. It is said that the ansewr
      # 'belongs_to' the question

      # As of Rails 5, thsi will add an index
      # to the foreign_key field (in this case,
      # question_id). If you don't want an index
      # you can pass the option 'index: false'

      # Big Int can fo from -9,223,372,036,854,775,808
      # to 9,223,372,036,854,775,807

      # Int can go from -2,147,483,648 to 2,147,483,647

      t.timestamps
    end
  end
end
