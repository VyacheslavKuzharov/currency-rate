# frozen_string_literal: true

class CbrClient
  ROOT_ENDPOINT = 'https://www.cbr-xml-daily.ru'

  def initialize
    @http_client = Faraday.new(url: ROOT_ENDPOINT)
  end

  def daily_list
    res = http_client.get('daily_json.js')

    raise "Could not fetch data from #{ROOT_ENDPOINT}" if res.status != 200

    JSON.parse(res.body)
  end

  def usd_rate
    daily_list['Valute']['USD']['Value']
  end

  private

  attr_reader :http_client
end