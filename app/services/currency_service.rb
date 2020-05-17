# frozen_string_literal: true

class CurrencyService

  def initialize(currency)
    @currency = currency
    @client = CbrClient.new
  end

  def call
    init_new_currency if currency.nil?
    currency_amount = client.public_send("#{currency.name}_rate")

    save_and_broadcast!(currency_amount)
    currency
  end

  private

  attr_reader :currency, :client

  def init_new_currency
    @currency = Currency.new(name: currency.name)
  end

  def save_and_broadcast!(currency_amount)
    currency.amount = currency_amount
    currency.forced = false
    currency.save!
    ActionCable.server.broadcast 'notifications_channel', amount: currency.amount
  end
end