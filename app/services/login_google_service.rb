# frozen_string_literal: true

require "httparty"
require "json"

class LoginGoogleService
  include HTTParty

  def initialize id_token
    @id_token = id_token
    @google_oauth2_url = "https://www.googleapis.com/oauth2/v3"
  end

  def get_user_google_info
    url = URI.parse("#{@google_oauth2_url}/tokeninfo?id_token=#{@id_token}")
    response = HTTParty.get(url)
    unless response.success?
      raise Api::Error::BadRequestController,
            I18n.t("service.errors.authenticate.google_invalid_account")
    end

    response.parsed_response
  end
end
