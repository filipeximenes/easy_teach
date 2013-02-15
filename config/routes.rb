EasyTeach::Application.routes.draw do
  devise_for :teachers
  
  root :to => "static_pages#root"

  resource :teacher, only: [:create, :edit, :update]
  resources :indices_show, only: [:show]
  resources :indices, only: [] do
    collection do
      get :dashboard
    end
  end
  resources :classroom_show, only: [:show]
  resources :classrooms, only: [:new, :edit, :create,  :update, :destroy] do
    member do
      get :students
      get :messages
    end
  end
  resources :invited_teachers, only: [:new, :create]
  resources :enrolled_emails, only: [:edit, :create, :update, :destroy] do
    member do
      put :accept
    end
  end
  resources :messages, only: [:show] do
    collection do
      get '/message_to/:messageable_type/:messageable_id', to: "messages#new_message_to", as: "send_to"
      post '/message_to/:messageable_type/:messageable_id', to: "messages#create_message_to", as: "send_to"
      post '/from_enrolled_email/:classroom_id', to: "messages#create_message_from_enrolled_email", as: "send_from_enrolled_email"
    end
    member do
      get '/response', to: "messages#new_response_to", as: "response_to"
      post '/response', to: "messages#create_response_to", as: "response_to"
    end
  end

  match '/home', to: "static_pages#home", as: 'home'

  match '/:indexable_slug', to: "indices_show#indexable_page", as: 'indexable_page', via: :get
  match '/:indexable_slug/:classroom_slug', to: "classroom_show#classroom_page", as: 'classroom_page', via: :get
  match '/:indexable_slug/:classroom_slug/enroll', to: "enrolled_emails#new", as: 'new_enrolled_email', via: :get
end
