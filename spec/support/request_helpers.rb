# frozen_string_literal: true

module RequestHelpers
  def parsed_json(response)
    JSON.parse(response.body)
  rescue JSON::ParserError
    false
  end
end