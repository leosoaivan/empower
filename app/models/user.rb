class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :contacts
  
  validates :first_name,  presence: true
  validates :last_name,   presence: true
  validates :username,    presence: true,
                          uniqueness: { case_sensitive: false }
  validates :email,       presence: true,
                          uniqueness: { case_sensitive: false }
  validates :password,    presence: true,
                          length: { minimum: 6 }
end
