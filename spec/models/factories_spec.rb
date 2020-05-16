# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Factories' do
  specify 'are valid' do
    FactoryBot.lint traits: true
  end
end