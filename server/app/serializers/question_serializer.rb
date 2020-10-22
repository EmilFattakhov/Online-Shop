# rails g serializer question 👈🏻terminal command for generating this serializer
class QuestionSerializer < ActiveModel::Serializer
  #  attributes :id, :title, :body, :randomstuff, :created_at, :updated_at,:view_count,:like_count
  
  # As Rails checks the serializer of model name first and then send the JSON accordingly if it finds the serializer as per model name.
  
  attributes( 
    :id,
    :title,
    :body,
    :randomstuff, 
    :created_at, 
    :updated_at,
    :view_count,
    :like_count
  )
  belongs_to :user, key: :author
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :first_name, :last_name, :full_name
  end
  has_many :answers
  class AnswerSerializer < ActiveModel::Serializer
  
    attributes :id,:body,:created_at,:updated_at, :author_full_name
      def author_full_name
        object.user&.full_name
      end
  end

  def randomstuff
    "You can add you random stuff here"
  end
  def like_count
    object.likes.count
  end
end
