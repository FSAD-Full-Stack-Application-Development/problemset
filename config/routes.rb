Rails.application.routes.draw do
  devise_for :users
  root "main#index"           # homepage points to main#index

  # Problem Set 1 - existing basics functionality
  get "/ps1", to: "basics#index", as: :ps1
  get "/basics", to: "basics#index", as: :basics  # keep existing route for compatibility

  # Problem Set 2 - tech jokes database
  scope "/ps2" do
    get "/", to: "jokes#index", as: :ps2
    get "/jokes", to: "jokes#index", as: :jokes
    post "/jokes", to: "jokes#create"
    get "/search", to: "jokes#search", as: :search_jokes
    get "/about", to: "jokes#about", as: :jokes_about
    get "/export", to: "jokes#export", as: :export_jokes
    post "/import", to: "jokes#import", as: :import_jokes
    post "/kill_joke/:id", to: "jokes#kill_joke", as: :kill_joke
    post "/erase_personalization", to: "jokes#erase_personalization", as: :erase_personalization
  end

  # Problem Set 3 - project tracker
  scope "/ps3" do
    get "/", to: "ps3_projects#index", as: :ps3
    resources :ps3_projects do
      resources :ps3_students
      member do
        post :add_student
      end
    end
    resources :ps3_students
  end

  # Problem Set 4 - user management requirements
  get "/ps4", to: "ps4_requirements#index", as: :ps4

  # Problem Set 5 - user evaluation
  get "/ps5", to: "ps5_evaluation#index", as: :ps5

  resources :projects
  get "up" => "rails/health#show", as: :rails_health_check
end
