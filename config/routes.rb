# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'

  namespace :admin do
    get '/', to: 'dashboard#index'
  end
end
