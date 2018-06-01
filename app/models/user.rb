class User < ApplicationRecord
  after_create :assign_default_role

  rolify

   # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, :timeoutable
         
  has_many :contacts
  
  validates :first_name,  presence: true
  validates :last_name,   presence: true
  validates :username,    presence: true, uniqueness: { case_sensitive: false }
  validates :email,       presence: true, uniqueness: { case_sensitive: false }
  validates :password,    presence: true, length: { minimum: 6 }

  delegate :can?, :cannot?, to: :ability

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def ability
    @ability ||= Ability.new(self)
  end

  private

  def assign_default_role
    self.add_role(:guest) if self.roles.blank?
  end
end