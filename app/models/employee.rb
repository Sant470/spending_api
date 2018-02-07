class Employee < ApplicationRecord
  has_secure_password
  has_one :card
  has_many :transacts
  validates :name, presence: true
  validates :unique_id, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true, format: { with:  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "invalid email format", on: :create}
  validates :mobile_no, length: {is: 10, message: "mobile no has to be of 10 digits"}, presence: true, uniqueness: true
  before_save {self.email = email.downcase}

  #all those which does n't have any card
  def self.available_employees
    Employee.includes(:card).where(cards: {employee_id: nil}).as_json(except: [:password_digest])
  end

  def transactions
    self.as_json(only: [:id, :mobile_no], methods: [:card_number], include: {transacts: {only: [:id, :transaction_time, :amount, :status], methods: [:merchant_name]}})
  end

  def card_number
    self.card.card_number
  end

end
