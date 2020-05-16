# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root 'welcome#index'

  namespace :admin do
    get '/', to: 'dashboard#index'
  end
end
