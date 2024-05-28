# frozen_string_literal: true

require "httparty"
require "json"

class GoogleService
  include HTTParty

  def initialize id_token
    @id_token = id_token
    @google_oauth2_url = "https://www.googleapis.com/oauth2/v3"
  end

  def get_token_info
    url = URI.parse("#{@google_oauth2_url}/tokeninfo?id_token=#{@id_token}")
    response = HTTParty.get(url)
    
    raise "Error getting token info: #{response.code} - #{response.message}" unless response.success?

    response.parsed_response
  end
end
