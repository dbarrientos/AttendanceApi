class User < ApplicationRecord
  has_secure_password
  has_many :attendances
  # Validations
  validates_presence_of :firstname, :lastname, :email, :password_digest

  enum role: [:employee, :admin]
end
