# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @currency = Currency.find_by(name: 'usd')
  end
end