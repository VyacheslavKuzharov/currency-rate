# frozen_string_literal: true

class CurrencyService

  def initialize(name)
    @currency_name = name
    @currency = Currency.find_by(name: name)
    @client = CbrClient.new
  end

  def call
    init_new_currency if currency.nil?
    currency_amount = client.public_send("#{currency_name}_rate")

    currency.amount = currency_amount
    currency.save!
    currency
  end

  private

  attr_reader :currency, :currency_name, :client

  def init_new_currency
    @currency = Currency.new(name: currency_name)
  end
end