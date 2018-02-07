class FinancialYear < ApplicationRecord
  validates :start_date, uniqueness: true, presence: true
  validates :end_date, uniqueness: true, presence: true
  has_many :months_limits, dependent: :destroy

  def self.get_financial_year transaction_time
    FinancialYear.where(["start_date < ? and end_date > ?", transaction_time, transaction_time]).first
  end
  
end
