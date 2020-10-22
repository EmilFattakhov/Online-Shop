class QuestionsController < ApplicationController
    before_action :find_question, only: [:show, :edit, :update, :destroy]
    # before_action is a controller hook provided by rails
    # 1 - it accepts a method name
    # 2 - options hash
    before_action :authenticate_user!, except: [:index, :show]
    # will call authenticate_user! before every method except :index, and :show
    before_action :authorize!, only: [:edit, :update, :destroy]
    
    def new
        @question = Question.new
    end

    def create
        # The 'params' object available in controllers 
        # is composed of the query string, url params, 
        # and the body of a form
        # (e.g. req.query + req.params + req.body)

        # A good trick to use if your routes are working 
        # and you're getting the data that you want, is to
        # render the params as JSON. this is like doing
        # res.send(req.body) in Express

        # Use 'require' on the params object to retrieve 
        # the nested hash of a key usually corresponding to 
        # the name~value pairs of a form

        # The use permit to specify all input names that 
        # are allowable (as symbols).
        @question = Question.new question_params # question_params are title and body in our case
        @question.user = current_user
        if @question.save
            flash[:notice] = 'Question created successfully'
            # if question is saved successfully, redirect to question show page with that question
            redirect_to question_path(@question)
        else 
            # render views/questions/new.html.erb
            render :new 
        end
    end

    def show
        # For the form_with helper
        @answer = Answer.new
        # For the list of answer
        @answers = @question.answers.order(created_at: :desc)

        @like = @question.likes.find_by(user: current_user)
    end

    def index
        if params[:tag]
            @tag = Tag.find_or_initialize_by(name: params[:tag])
            @questions = @tag.questions.all_with_answer_counts.order('updated_at DESC')
        else
            @questions = Question.all.all_with_answer_counts.order('updated_at DESC')
        end
        # curl -H "Accept: application/json" http://localhost:3000/questions 👈🏻Use this command in seperate terminal screen. Don't try to run it in the terminal where you are running your server.
        respond_to do |format|
            format.html {render}
            format.json {render json: @questions}
        end
    end

    def edit
    end 

    def update
        # attempt to edit the existing question with new values
        if @question.update question_params
            redirect_to question_path(@question)
        else
            render :edit
        end

    end

    def destroy 
        flash[:notice] = "Question destroyed!"
        @question.destroy 
        redirect_to questions_path
    end

    def liked 
        # all the question that this particular logged in user has liked
        @questions = current_user.liked_questions.all_with_answer_counts.order(created_at: :desc)
    end

    private 

    def question_params
        # params.require(:question): We must have a question object
        # the params of this request

        # .permit(:title, :body): for security reasons we need to only permit
        # the title and the body keys/attributes of the question 
        params.require(:question).permit(:title, :body, :tag_names)
    end

    def find_question
        # get the Question with the id that's requested
        @question = Question.find params[:id]
    end

    def authorize! 
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, @question)
    end

end
