Dummy::Application.routes.draw do
  root to: 'sample#index'

  get '/jt', to: 'sample#jt'
end
