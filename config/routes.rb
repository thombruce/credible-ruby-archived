Credible::Engine.routes.draw do
  scope module: 'authentication', format: false, defaults: { format: 'json' } do
    # /auth/login.json
    post 'login', to: 'sessions#create'
    # /auth/reset_password.json
    post 'reset_password', to: 'users#reset_password'
    # /auth/signup.json
    post 'signup', to: 'users#create'
    # /auth/confirm.json
    get 'confirm/:confirmation_token', to: 'users#confirm'
    # /auth/signout.json
    delete 'signout', to: 'sessions#destroy'

    # /auth/account/**/*.json
    scope '/account' do
      # /auth/account/sessions/*.json
      resources :sessions, except: [:new, :create, :edit, :update]
      # /auth/account/*.json
      resource :user, path: '', except: [:new, :create]
    end
  end
end
