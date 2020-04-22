Rails.application.routes.draw do
  mount Credible::Engine => "/credible"

  root to: "welcome#index"
end
