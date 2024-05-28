# frozen_string_literal: true

class Api::V1::User::SessionsController < ActionController::API
  def create
    google_service = GoogleService.new(params[:id_token])
    token_info = google_service.get_token_info

    resource = User.create_user_for_google(token_info)
    response_with resource
  rescue StandardError => e
    render json: {error: e.message}, status: :unprocessable_entity
  end

  private

  def response_with resource
    render json: {
      user: Api::V1::User::UserSerializer.new(resource, type: :basic_info)
    }
  end
end
