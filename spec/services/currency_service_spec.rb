# frozen_string_literal: true

require 'rails_helper'
require 'clients/cbr_client'

RSpec.describe CurrencyService do
  let(:currency_name) { 'usd' }
  let(:subject) { described_class.new(currency_name) }

  describe 'CurrencyService is initialized' do
    subject { described_class }

    it { is_expected.to respond_to(:new) }
  end

  describe 'instance' do
    it { is_expected.to respond_to(:call) }
  end

  context 'new currency' do
    it 'creates new currency record' do
      VCR.use_cassette('daily_list') do
        expect do
          expect(subject.call).to be_truthy
        end.to change { Currency.count }.by(1)
      end
    end
  end

  context 'current currency' do
    let!(:current_currency) { create :currency, amount: 62.3 }

    it 'updates record' do
      VCR.use_cassette('daily_list') do
        subject.call
        expect(Currency.first.amount.to_f).to eq(73.21)
      end
    end
  end
end
