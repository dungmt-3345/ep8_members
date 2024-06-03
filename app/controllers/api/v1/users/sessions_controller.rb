# frozen_string_literal: true

class Api::V1::Users::SessionsController < Api::BaseController
  def create
    google_service = LoginGoogleService.new(params[:id_token])
    user_google_info = google_service.get_user_google_info

    resource = User.create_user_for_google(user_google_info)
    response_with resource
  end

  private

  def response_with resource
    render json: {
      user: Api::V1::UserSerializer.new(resource, type: :basic_info)
    }
  end
end
