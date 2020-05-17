# frozen_string_literal: true

class CurrencyService

  def initialize(name)
    @currency_name = name
    @currency = Currency.find_by(name: name)
    @client = CbrClient.new
  end

  def call
    init_new_currency if currency.nil?
    return if forced_in_progress?

    currency_amount = client.public_send("#{currency_name}_rate")

    save_and_broadcast!(currency_amount)
    currency
  end

  private

  attr_reader :currency, :currency_name, :client

  def init_new_currency
    @currency = Currency.new(name: currency_name)
  end

  def save_and_broadcast!(currency_amount)
    currency.amount = currency_amount
    currency.forced = false
    currency.save!
    ActionCable.server.broadcast 'notifications_channel', amount: currency.amount
  end

  def forced_in_progress?
    return if currency.forced_data.blank?

    currency.forced && Time.parse(currency.forced_data['dead_line']).future?
  end
end