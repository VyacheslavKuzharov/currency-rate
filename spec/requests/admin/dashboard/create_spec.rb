# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin dashboard#create', type: :request do
  let(:url) { admin_currency_forced_path }
  let!(:currency) { create :currency }

  context 'failure' do
    it 'with invalid attr amount not create a new one' do
      expect {
        post url, params: { currency: { currency_id: currency.id, amount: nil } }
        expect(response).to be_ok
      }.to change { Currency.count }.by(0)
    end

    it 'with invalid attr amount respond with error' do
      post url, params: { currency: { currency_id: currency.id, amount: 'qwe' } }
      expect(response.body).to include 'Format should be: XX.XX'
    end
  end

  context 'success' do
    it 'with valid attributes' do
      post url, params: { currency: { currency_id: currency.id, amount: '12.33', dead_line: '2020-05-18 12:00' } }
      expect(response).to be_redirect
      expect(Currency.last.forced_data['dead_line']).to eq('2020-05-18 12:00')
    end
  end
end
