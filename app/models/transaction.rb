class Transaction < ApplicationRecord
  validates :amount, :numericality => { :greater_than_or_equal_to => 0 }, presence: true
  has_one :spending, dependent: :destroy
  belongs_to :mcc_code
  belongs_to :employee
  before_save :validate_against_mcc_code


  def validate_against_mcc_code
    check_card_status
    if self.employee.card.card_types.mcc_codes.pluck(:code).include? self.mcc_code.code
      self.status = true
    else
      self.status = false
    end
  end

  def check_card_status
    return false  if self.employee.card.nil?
  end

end
