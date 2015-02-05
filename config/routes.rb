Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'

  devise_for :users
  resources :learned_words
  resources :learnings
  resources :words

  resources :courses do
    member do
      get 'learn'
    end
  end
end
