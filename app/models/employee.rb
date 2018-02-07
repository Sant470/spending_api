class Employee < ApplicationRecord
  has_secure_password
  has_one :card
  validates :name, presence: true
  validates :unique_id, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true, format: { with:  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "invalid email format", on: :create}
  validates :mobile_no, length: {minimum: 10, maximum: 10, message: "mobile no has to be of 10 digits"}, presence: true, uniqueness: true
  before_save {self.email = email.downcase}

  #all those which does n't have any card
  def self.available_employees
    Employee.includes(:card).where(cards: {employee_id: nil}).as_json(except: [:password_digest])
  end

end
