class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: {case_insenssiitve: false}
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  has_secure_password
end
