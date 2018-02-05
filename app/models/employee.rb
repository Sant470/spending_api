class Employee < ApplicationRecord
  has_one :card
  validates :name, presence: true
  validates :uniqe_id, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true, format: { with:  /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i, message: "invalid email format", on: :create}
  validates :mobile_no, length: {minimum: 10, maximum: 10, message: "mobile no has to be of 10 digits"}, presence: true
  before_save {self.email = email.downcase}
end
