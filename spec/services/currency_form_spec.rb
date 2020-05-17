# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CurrencyForm do
  let(:currency) { create :currency }
  let(:subject) { described_class.new(currency) }
  let(:params) { { currency_id: '2', amount: '12.33', dead_line: '2020-05-18 12:00' } }

  describe 'CurrencyForm is initialized' do
    subject { described_class }

    it { is_expected.to respond_to(:new) }
  end

  context 'currency empty' do
    let(:currency) { nil }

    it 'submit failed' do
      form = subject.submit(params)
      expect(form).to be_falsey
    end
  end

  context 'currency' do
    it 'submit succeded' do
      form = subject.submit(params)
      expect(form).to be_truthy
    end
  end
end
