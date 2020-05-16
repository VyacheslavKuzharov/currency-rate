# frozen_string_literal: true

class WelcomeController < ApplicationController
  def index
    @currency = Currency.first
  end
end