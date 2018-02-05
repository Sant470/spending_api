class MccCode < ApplicationRecord
  has_many :card_type_mcc_codes, dependent: :destroy
  has_many :card_types, through: :card_type_mcc_codes
  validates :code, uniqueness: true, length:{minimum: 3, maximum: 3, message: "mcc code has to be of 3 characters"}, presence: true
  validates :name, presence: true
  before_save {self.code = code.upcase}
end
