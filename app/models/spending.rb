class Spending < ApplicationRecord
  validates :amount, presence: true
  before_save :validate_positiveness

  belongs_to :transact, foreign_key: 'transaction_id'
  belongs_to :months_limit
  belongs_to :employee

  def validate_positiveness
    raise Exception "amount has to be non negative" if self.amount < 0
  end

end
