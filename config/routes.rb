Rails.application.routes.draw do
  resources :high_scores

  # Sidekiq dashboard
  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"

  # Sidekiq trigger
  get "/dummy" => "dummy#index", as: "dummy_index"
  get "/dummy/report" => "dummy#report", as: "dummy_report"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
