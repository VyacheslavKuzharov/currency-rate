# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin dashboard#index', type: :request do
  specify do
    get admin_path
    expect(response).to be_ok
  end
end