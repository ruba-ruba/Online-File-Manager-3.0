class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :role

  ROLES = %w[user admin]

  validates :role, :inclusion => { :in => ROLES }

  before_validation :default_role

  private

  def default_role
    self.role = "user"
  end

end
