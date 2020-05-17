# frozen_string_literal: true

class UnblockCurrencyJob
  include Sidekiq::Worker
  sidekiq_options queue: :default

  def perform(currency_name)
    CurrencyService.new(currency_name).call
  end
end