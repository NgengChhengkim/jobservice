Rails.application.routes.draw do
  apipie
  devise_for :users

  namespace :api do
    namespace :v1 do
      use_doorkeeper do
        controllers tokens: "sessions"
      end
    end
  end
end
