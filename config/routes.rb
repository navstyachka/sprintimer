Sprintimer::Application.routes.draw do

  root to: "timer#index"

  scope format: true, constraints: { format: 'json' } do
    resources :timer, only: [:create]
  end

end
