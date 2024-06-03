# frozen_string_literal: true

class Token < ApplicationRecord
  belongs_to :user

  validates :access_token, presence: true, uniqueness: true
  validates :access_token_expires_at, presence: true,
             comparison: {greater_than: Time.now + Settings.token.access_token_expires_at.hours}
end
