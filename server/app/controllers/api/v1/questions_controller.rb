# module api
# module v1
# class Api::V1::QuestionsController < ApplicationController
# end
# end
# end
# 👇🏻 This line is simillar to this 👆🏻
class Api::V1::QuestionsController < Api::ApplicationController
  # 👆🏻This Api QuestionController inherits from Application Controller
  # rails g controller api/v1/questions --no-assets --no-helper --skip-template-engine
  # 👆🏻This will generate questions_controller in controllers/api/v1
  def index
    questions = Question.order(created_at: :desc)
    render(json: questions, each_serializer: QuestionCollectionSerializer)
  end

  # curl http://localhost:3000/api/v1/questions 👈🏻 To see json reply in terminal
  def show
    # curl http://localhost:3000/api/v1/questions/4 👈🏻 To see json reply in terminal for particular question id
    question = Question.find(params[:id])
    render(json: question)
  end

  def create
    question=Question.new(params.require(:question).permit(:title, :body, :tag_names))
    question.user = current_user  #User.first
    if question.save
        render json:{id: question.id}
    else
        render(
            json: {errors: question.errors},
            status:422 #unprocessable entity HTTP Status code
        )
    end
  end

  def destroy
    question = Question.find_by_id(params[:id])
    if question&.destroy
      head :ok
    else
      head :bad_request
    end
  end
end
