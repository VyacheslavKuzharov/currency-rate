# frozen_string_literal: true

require 'rails_helper'
require 'clients/cbr_client'

RSpec.describe CbrClient do
  let(:subject) { described_class.new }

  it 'fetched daily list json' do
    VCR.use_cassette('daily_list') do
      res = subject.daily_list

      expect(res['Valute']).not_to be_empty
    end
  end

  it 'fetched usd rate' do
    VCR.use_cassette('daily_list') do
      res = subject.usd_rate

      expect(res['ID']).to eq('R01235')
    end
  end
end
