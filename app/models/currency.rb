# frozen_string_literal: true

class Currency < ApplicationRecord

  validates :name, uniqueness: true
end
