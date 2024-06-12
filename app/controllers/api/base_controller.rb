# frozen_string_literal: true

class Api::BaseController < ActionController::API
  include Api::V1::BaseConcern

  before_action :authenticate_user!

  def authenticate_user!
    raise_unauthorized_error unless valid_token?
  end

  private

  attr_reader :current_user

  def valid_token?
    access_token = request.headers["Authorization"]&.split&.last
    return false unless access_token

    token = Token.valid_token(access_token).first # thanh 1 object
    return false if token.nil?

    @current_user = token.user
  end

  def raise_unauthorized_error
    raise Api::Error::Unauthorized, I18n.t("errors.action.unauthorized")
  end
end
