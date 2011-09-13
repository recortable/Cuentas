# encoding: UTF-8


Cuentas::Application.routes.draw do
  get "activities/index"

  get "activities/destroy"

  root :to => "dashboard#show"


  resources :accounts, :path => 'cuentas' do
    resources :movements, :path => 'movimientos' do
      resources :comments, :path => 'comentarios'
    end
    resources :tags, :path => 'etiquetas' do
      put 'calculate', :on => :collection
    end
    resources :taggings
    resources :months, :path => 'meses'
    resources :years, :path => 'anyos' do
      put 'calculate_months', :on => :member
    end
    resources :actions
    resource :import, :path => 'importar' do
      post 'preview'
    end
  end

  namespace :admin do
    resources :users
    resources :accounts
    resources :movements
    resources :activities
  end

  match "/auth/:provider/callback" => "sessions#create"
  match "/cerrar" => "sessions#destroy", :as => :logout
  match "/identificarse" => "sessions#new", :as => :login
  match "/admin" => "admin/activities#index"
  match "/enter/:id" => 'sessions#enter' unless Rails.env.production?
end
