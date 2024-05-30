# frozen_string_literal: true

class Progose < ApplicationRecord
  belongs_to :user

  validates :date_test, presence: true
  validates :range, :range_evaluation, :accuracy, :accuracy_evaluation, :fluency,
            :fluency_evaluation, :interaction, :interaction_evaluation, :coherence,
            :coherence_evaluation, :phonology, :phonology_evaluation, :overall,
            :overall_evaluation, presence: true

  scope :newest, -> { order(id: :desc) }

  [:range, :accuracy, :fluency, :interaction, :coherence, :phonology].each do |attribute|
    enum_attribute = {
      A1: 1, A2: 2, B1: 3, B2: 4, C1: 5, C2: 6
    }.transform_keys { |key| "#{key}_#{attribute}" }

    enum attribute, enum_attribute, _suffix: true
  end

  enum overall: {
    A1: 1, A1_high: 2,
    A2: 3, A2_high: 4,
    B1: 5, B1_high: 6,
    B2: 7, B2_high: 8,
    C1: 9, C1_high: 10,
    C2: 11, C2_high: 12
  }, _suffix: true

  PROGOSE_CREATE_ATTRS = %i(date_test range range_evaluation accuracy accuracy_evaluation
                            fluency fluency_evaluation interaction interaction_evaluation
                            coherence coherence_evaluation phonology phonology_evaluation
                            overall overall_evaluation).freeze
end
