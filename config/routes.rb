# frozen_string_literal: true

require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  root 'welcome#index'

  namespace :admin do
    get '/', to: 'dashboard#index'
  end
end
