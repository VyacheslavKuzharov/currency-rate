# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Currency, type: :model do
  before { create :currency }

  it { is_expected.to validate_uniqueness_of :name }
end
