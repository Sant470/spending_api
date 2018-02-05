class FinancialYear < ApplicationRecord
  validates :start_date, uniqueness: true, presence: true
  validates :end_date, uniqueness: true, presence: true
  has_many :months_limits, dependent: :destroy
end
