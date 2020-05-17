class UnblockCurrencyJob
  include Sidekiq::Worker
  sidekiq_options queue: :default

  def perform(currency_id)
    currency = Currency.find(currency_id)

    CurrencyService.new(currency).call
  end
end