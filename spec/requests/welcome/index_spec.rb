# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Welcome#index', type: :request do
  let(:url) { root_path }

  it 'is ok' do
    get url
    expect(response).to be_ok
  end

  it 'with title' do
    get url
    expect(response.body).to include 'Currency Rate'
  end
end
