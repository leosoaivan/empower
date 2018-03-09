class User < ApplicationRecord
  has_many :contacts
  
  validates :name,      presence: true
  validates :username,  presence: true,
                        uniqueness: { case_sensitive: false }
  validates :email,     presence: true,
                        uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password,  presence: true,
                        length: { minimum: 6 }
end
