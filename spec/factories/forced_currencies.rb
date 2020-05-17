# frozen_string_literal: true

FactoryBot.define do
  factory :forced_currency do
    amount { '9.99' }
    dead_line { 3600 }
  end
end
