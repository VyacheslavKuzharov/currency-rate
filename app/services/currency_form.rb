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

  validate :validate_time

  def initialize(currency)
    @currency = currency
  end

  def submit(params)
    @amount = params[:amount]
    @dead_line = params[:dead_line]

    if valid?
      cleanup_previous_job!
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

  def validate_time
    if Time.parse(@currency.forced_data['dead_line']).past?
      errors.add(:base, 'time cannot be past!')
    end
  end

  def cleanup_previous_job!
    return if @currency.nil?

    Sidekiq::ScheduledSet.new.find_job(@currency.forced_data['jid'])&.delete
  end

  def forced_currency_amount!
    jid = UnblockCurrencyJob.perform_in(forced_interval, @currency.name)
    @currency.update(amount: amount, forced: true, forced_data: { amount: amount, dead_line: dead_line, jid: jid })
    ActionCable.server.broadcast 'notifications_channel', amount: amount
  end

  # Stay in system time zone for simplicity
  def forced_interval
    ((Time.parse(dead_line) - Time.now) / 1.second).round
  end
end