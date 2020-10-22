class AnswersController < ApplicationController
    # This file was generated with the command:
    # rails g controller answers --skip-template-engine
    # The skip-template-engine option just skips
    # generating a folder '/views/answers'
    
    def create 
        # POST PATH = /questions/:question_id/answers
        @question = Question.find params[:question_id]
        # @question = { id: 1, title: 'your question title', body: 'your question body', ...}
        @answer = Answer.new answer_params
        # @answer = { body: 'your answer' }
        @answer.question = @question # @answer = { body: 'your answer', question_id: 1 }
        @answer.user = current_user
        if @answer.save
            # AnswerMailer.new_answer(@answer).deliver_now
            AnswerMailer.new_answer(@answer).deliver_later
            redirect_to question_path(@question)
        else 
            # For the list of answers
            @answers = @question.answers.order(created_at: :desc)
            render 'questions/show'
        end
    end

    def destroy
        # DELETE PATH = /questions/:question_id/answers/:id
        @answer = Answer.find params[:id]
        if can?(:crud, @answer) 
            @answer.destroy 
            redirect_to question_path(@answer.question)
        else
            # head will send an empty HTTP response with
            # a particular response code, in this case
            # unauthorized 401
            # http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/
            head :unauthorized
            # redirect_to root_path, alert: 'Not Authorized'
        end
    end

    private

    def answer_params 
        params.require(:answer).permit(:body)
    end
end
