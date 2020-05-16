# frozen_string_literal: true

require 'sidekiq-scheduler'
require 'clients/cbr_client'

class FetchUsdCurrencyJob
  include Sidekiq::Worker
  sidekiq_options queue: :default

  def perform
    puts 'worker howdy!'
  end
end