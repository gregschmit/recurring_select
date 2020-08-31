Dummy::Application.routes.draw do
  post '/result', to: 'sample#result', as: :result
  root to: 'sample#index'
end
