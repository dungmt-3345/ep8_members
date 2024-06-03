# frozen_string_literal: true

class Api::V1::UserSerializer < BaseSerializer
  attributes :id, :name_roma, :name_kata, :email

  BASIC_INFO = %i(id email name_roma).freeze

  def attributes *attrs
    super.slice(*fields_custom)
  end
end
