class Transaction < ApplicationRecord
  has_many :spendings, dependent: :destroy
  belongs_to :employee
  belongs_to :card

  before_save :validate_against_mcc_code

  def validate_against_mcc_code
    if self.card.card_types.mcc_codes.pluck(:code).include? self.mcc_code
      self.status = true
    else
      self.status = false
    end
  end
end
