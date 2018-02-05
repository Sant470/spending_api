class CardType < ApplicationRecord
  enum category: ["zeal", "zinger"]
  validates :category, presence: true, uniqueness: true
  has_many :card_type_mcc_codes, dependent: :destroy
  has_many :mcc_codes, through: :card_type_mcc_codes
  has_many :cards
end
