# frozen_string_literal: true

class Currency < ApplicationRecord

  validates :name, uniqueness: true

  has_many :forced_currencies
end
