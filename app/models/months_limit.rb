class MonthsLimit < ApplicationRecord
  enum month: ["jan", "ferb", "march", "april", "may", "june", "july", "aug", "sep", "oct", "nov", "dec"]
  validates :limit, presence: true
  has_many :spendings, dependent: :destroy
  belongs_to :mcc_code
  belongs_to :financial_year
  before_save :non_negativity

  def non_negativity
    raise Exception "amount has to be non negative" if self.limit < 0
  end
end
