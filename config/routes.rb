Sprintimer::Application.routes.draw do

  root to: "timer#index"

  resources :timer, only: [:create]

end
