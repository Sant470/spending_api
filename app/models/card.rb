class Card < ApplicationRecord
  belongs_to :employee, optional: true
  belongs_to :card_type
  validates :card_number, uniqueness: true, numericality: true, length: {is: 16, message: "card number has to be of 16 digit"}
  validates :ccv, length: {is: 3,  message: "ccv has to be of 3 digits"}, presence: true
  validates :expire_date, presence: true
  before_save :validate_expire_date

  def validate_expire_date
    raise Exception "expire date could not be in past" if self.expire_date <= Date.today
  end
end
