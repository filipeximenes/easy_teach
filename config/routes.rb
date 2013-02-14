EasyTeach::Application.routes.draw do
  devise_for :teachers
  
  root :to => "static_pages#root"

  resource :teacher, only: [:create, :edit, :update]
  resources :indices, only: [:show] do
    collection do
      get :dashboard
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
      post :enrolled_email_classroom
      post :teacher_enroled_email
    end
  end
  resources :classroom_show, only: [:show]
  resources :classrooms, only: [:new, :edit, :create,  :update, :destroy] do
    member do
      get :students
      get :messages
      get '/message/:message_id', to: "classrooms#show_enrolled_email_message", as: "enrolled_email_message"
      post '/message/:message_id', to: "classrooms#answer_enrolled_email_message", as: "enrolled_email_message"
    end
  end

  match '/home', to: "static_pages#home", as: 'home'

  match '/:indexable_slug', to: "indices#indexable_page", as: 'indexable_page', via: :get
  match '/:indexable_slug/:classroom_slug', to: "classroom_show#classroom_page", as: 'classroom_page', via: :get
  match '/:indexable_slug/:classroom_slug/enroll', to: "enrolled_emails#new", as: 'new_enrolled_email', via: :get
end
