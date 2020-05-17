# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin dashboard#index', type: :request do

  describe 'is ok' do
    let!(:currency) { create :currency }

    it 'respond with ok' do
      get admin_path
      expect(response).to be_ok
    end
  end
end