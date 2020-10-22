Rails.application.routes.draw do
  
  
  get "sessions/new"
  get "sessions/create"
  get "sessions/destroy"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # our application is running on localhost:3000
  # Inside of this file is where we define what resources we want to be
  # available to users

  # URL: http://localhost:3000/path
  # HTTP Request are used to interact with  our server. They are made up of a
  # HTTP VERB and PATH
  # VERB  PATH          CONTROLLER  PUBLIC METHOD
  # 👇    👇                👇        👇
  get("/hello_world", to: "welcome#hello_world") # when someone sends a GET
  # request to "/hello_world" path, they are routed (sent) to welcome controller,
  # hello_world action (method).

  # GET "/" WelcomeController.root method
  get "/", to: "welcome#root", as: "root"

  # GET "/contact_us"
  get("/contact_us", to: "welcome#contact_us")

  # POST "/process_contact"
  post("/process_contact", to: "welcome#process_contact")

  # Question Related Routes
  # question new page
  # when someone sends a GET request to /questions/new, it will be handled by the new actions
  # inside questions controller
  # get '/questions/new', {to: 'questions#new', as: :new_questions }

  # # handles submission of new questions form
  # post '/questions', {to: 'questions#create', as: :questions }

  # # question show page
  # get '/questions/:id', { to: 'questions#show', as: :question }

  # # questions index page
  # get '/questions', { to: 'questions#index' }

  # # question edit page
  # get '/questions/:id/edit', { to: 'questions#edit', as: :edit_question}

  # # handles submission of form on the question edit page
  # patch '/questions/:id', { to: 'questions#update' }

  # # delete a question
  # delete '/questions/:id', { to: 'questions#destroy' }

  # get "/questions/faq", to: "questions#faq"

  # Below line builds all of the above routes for us :)
  # resources :questions  build the CRUD RESTful routes. (all of the above
  #  routes for questions)
  # 'resources' method will generate all CRUD routes
  # following RESTful conventions for a resource
  # It will assume there is a controller named after the
  # first argument, pluralized and PascalCase
  resources :questions do
    resources :likes, shallow: true, only: [:create, :destroy]
    # shallow: true option changes the PATH of the created route
    # original route without shallow: true => /questions/19/likes/30
    # Route with shallow: true => likes/30

    # Routes written inside of a block passed to a resource
    # method will be pre-fixed by a path corresponding
    # to the passed in symbol.
    # In this case, all nested routes will be pre-fixed
    # with '/questions/:question_id'
    resources :answers, only: [:create, :destroy]
    # equivalent to:
    # resources :answers, except: [:show, :index, :new, :edit, :update]
    # questions_answers_path(<question_id>)
    # question_answer_url(<question_id>)
    # question_answers_path(@question)
    get :liked, on: :collection
    # above route creates a path like: GET "/questions/liked" kind of similar to questions index but only show the questions that the user has liked
  end

  resources :users, shallow: true,only: [:new, :create, :show] do
    resources :gifts, only: [:new, :create] do
      resources :payments, only: [:new, :create]
    end
  end

  # 'resource' is singular instead of 'resources'
  # Unlike 'resources', 'resource' will create routes
  # that do CRUD operation on only one thing. There will be no
  # index routes, and no route will have an ':id' wild card.
  # When using a singular resource, the controller must
  # still be plural.
  resource :session, only: [:new, :create, :destroy]

  resources :job_posts
  # http://localhost:3000/delayed_job/overview
  match("/delayed_job",
        to: DelayedJobWeb,
        anchor: false,
        via: [:get, :post])
  # http://localhost:3000/rails/info/routes 👈🏻Link to see all routes
  namespace :api, defaults: { format: :json } do #👈🏻 we can set default response format of the block
    namespace :v1 do
      resources :questions, only: [:create, :show,:index,:destroy, :update]
      resource :session, only:[:create]
      resources :users, only: [:create, :show]
      get "/current_user", to: "sessions#get_current_user_from_session"
    end
  end

  # 👆🏻http://localhost:3000/api/v1/questions
  # Step 4 - OmniAuth: Creating 2 Routes 1. SignIn route and 2. Callback route 👇🏻
  get "/auth/github", as: :sign_in_with_github
  # http://lvh.me:3000/auth/github/callback
  
  get "/auth/:provider/callback", to: "callbacks#index"

  
end
