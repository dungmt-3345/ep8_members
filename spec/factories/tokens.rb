# frozen_string_literal: true

FactoryBot.define do
  factory :token do
    access_token {Faker::Internet.uuid}
    access_token_expires_at {Time.now + 24.hours}
    association :user
  end
end
