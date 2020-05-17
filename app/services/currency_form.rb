# frozen_string_literal: true

# In real project is better idea to use dry-rb stack
class CurrencyForm
  include ActiveModel::Model

  attr_accessor :amount, :dead_line

  CURRENCY_AMOUNT_REGEXP = /\d+(\.\d{2})?/.freeze
  TIMESTAMP_REGEXP = /[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1]) (2[0-3]|[01][0-9]):[0-5][0-9]/.freeze

  validate :validate_currency

  validates :amount,
            format: { with: CURRENCY_AMOUNT_REGEXP, message: 'Format should be: XX.XX' },
            presence: true

  validates :dead_line,
            format: { with: TIMESTAMP_REGEXP, message: "it's not valid format!" },
            presence: true

  def initialize(currency)
    @currency = currency
  end

  def submit(params)
    @amount = params[:amount]
    @dead_line = params[:dead_line]

    if valid?
      forced_currency_amount!
      true
    else
      false
    end
  end

  private

  def validate_currency
    errors.add(:base, 'currency not found!') if @currency.nil?
  end

  def forced_currency_amount!
    @currency.update(amount: amount, forced: true, forced_data: { amount: amount, dead_line: dead_line })
    UnblockCurrencyJob.perform_in(forced_interval, @currency.name)
  end

  # Stay in system time zone for simplicity
  def forced_interval
    ((Time.parse(dead_line) - Time.now) / 1.second).round
  end
end