Rails.application.routes.draw do
  resource :session
  resources :users
  resources :questions do
    resources :answers, exept: %i[new show]
  end 
  root 'questions#first' 
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
  resource :session
  resources :users
  resources :questions
  resources :answers
  end
end
