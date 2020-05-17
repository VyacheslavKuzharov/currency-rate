# frozen_string_literal: true

FactoryBot.define do
  factory :currency do
    name { 'usd' }
    amount { 63.3956 }
    forced_data { {"jid": "f1bf877775be136a76730e17", "amount": "12.33", "dead_line": "2020-05-18 12:00"} }
  end
end
