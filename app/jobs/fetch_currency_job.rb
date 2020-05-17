# frozen_string_literal: true

require 'sidekiq-scheduler'
require 'clients/cbr_client'

class FetchCurrencyJob
  include Sidekiq::Worker
  sidekiq_options queue: :default

  def perform(name = 'usd')
    CurrencyService.new(name).call
  end
end