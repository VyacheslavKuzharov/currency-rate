# frozen_string_literal: true

require 'sidekiq-scheduler'
require 'clients/cbr_client'

class FetchCurrencyJob
  include Sidekiq::Worker
  sidekiq_options queue: :default

  def perform(name = 'usd')
    currency = Currency.find_by!(name: name)

    CurrencyService.new(currency).call unless currency.forced
  end
end