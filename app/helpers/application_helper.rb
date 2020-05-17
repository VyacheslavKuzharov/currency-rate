# frozen_string_literal: true

module ApplicationHelper
  def currency_amount_regexp
    CurrencyForm::CURRENCY_AMOUNT_REGEXP
  end
end
