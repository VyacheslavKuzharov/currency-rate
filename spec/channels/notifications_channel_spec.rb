# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NotificationsChannel, type: :channel do
  before do
    stub_connection
  end

  it 'subscribes without streams' do
    subscribe
    expect(subscription).to be_confirmed
  end

  it 'subscribes to a stream' do
    subscribe
    expect(subscription).to have_stream_from('notifications_channel')
  end
end
