# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :avatar

  enum :original_role, {Engineer: 0, BrSE: 1}
  enum :training_role, {BE: 0, FE: 1, Mobile: 2}
  enum :role, {admin: 0, user: 1}

  validates :name_roma, length: {maximum: Settings.user.max_length.name_roma}
  validates :name_kata, length: {maximum: Settings.user.max_length.name_kata}
  validates :email, length: {maximum: Settings.user.max_length.email},
                    presence: true, uniqueness: true,
                    format: {with: Settings.user.regex_email}
  validates :address, length: {maximum: Settings.user.max_length.address}
end
