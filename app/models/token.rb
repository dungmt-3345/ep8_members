# frozen_string_literal: true

class Token < ApplicationRecord
  belongs_to :user

  before_validation :generate_access_token

  validates :access_token, presence: true, uniqueness: true
  validates :access_token_expires_at, presence: true,
             comparison: {greater_than: Time.now + Settings.token.access_token_expires_at.hours}

  def self.valid_token access_token
    where("access_token = ? AND access_token_expires_at > ?", access_token, Time.now).includes(:user)
  end

  private

  def generate_access_token
    self.access_token = SecureRandom.hex(32)
    self.access_token_expires_at = Time.now + Settings.token.access_token_expires_at.hours
  end
end
