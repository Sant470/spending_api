class Transact < ApplicationRecord
  validates :amount, :numericality => { :greater_than_or_equal_to => 0 }, presence: true
  validate :check_card_status, :on => :create
  has_one :spending, dependent: :destroy
  belongs_to :mcc_code
  belongs_to :employee
  before_save :validate_against_mcc_code
  after_create :create_spending


  def validate_against_mcc_code
    if self.employee.card.card_type.mcc_codes.pluck(:code).include? self.mcc_code.code
      self.status = true
    else
      self.status = false
    end
  end

  def check_card_status
    if self.employee.card.nil?
      errors.add(:employee, "does not have any card")
    end
  end

  def create_spending
    financial_year = FinancialYear.get_financial_year self.transaction_time
    spend = Spending.new
    spend.amount = self.amount
    spend.months_limit = financial_year.months_limits.where(month: self.transaction_time.month-1, mcc_code: self.mcc_code).first
    spend.employee = self.employee
    spend.transact = self
    spend.save!
  end

  def merchant_name
    self.mcc_code.name
  end

end
