class Like < ApplicationRecord
    belongs_to :user 
    belongs_to :question

    # validates(
    #     :question_id, 
    #     uniqueness: true
    # )
    # the above validation is saying once a question is liked 
    # by a user. No other likes can be created for that particular
    # question
    # potential like records
    # |like_id|user_id|question_id|
    # | 1     | 30    | 14        |
    # | 2     | 31    | 14        | => user_id 31 can not like question 14 because a record
    # with qustion_id 14 already exist

    validates(
        :question_id, 
        uniqueness: {
            scope: :user_id,
            message: "has already been liked"
        }
    )
    # |like_id|user_id|question_id|
    # | 1     | 30    | 14        |
    # | 2     | 31    | 14        | <= this works because user_id is unique between the two records
    # | 3     | 31    | 14        | <= this doesn't work there's already a record with this same user_id question_id combo
end
