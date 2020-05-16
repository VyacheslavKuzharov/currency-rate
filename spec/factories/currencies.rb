# frozen_string_literal: true

FactoryBot.define do
  factory :currency do
    name { 'usd' }
    amount { 63.3956 }
  end
end
