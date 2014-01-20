class User < ActiveRecord::Base
  ROLES = %w[user admin]

  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :provider, :uid, :name, :token, :expires_at, :active
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:facebook]

  has_many :folders
  has_many :items
  has_many :comments
  has_many :votes

  validates :role, :inclusion => { :in => ROLES }

  before_validation :default_role, :on => :create
  before_create :generate_token
  before_create :set_expiration
  after_validation :report_validation_errors_to_rollbar


  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email,
                         password:Devise.friendly_token[0,20]
                         )
    end
    user
  end

  def as_api
    info = {}
    user = self
    total_quota = user.quota
    used_quota = user.items.sum(:file_file_size)
    info[:email] = user.email
    info[:total_quota] = total_quota
    info[:used] = used_quota
    info[:left_quota] = total_quota - used_quota
    info
  end

  def admin?
    role == 'admin'
  end

  def can_manage?(target)
    admin? || target.user_id == id
  end

  def space_used
    items.sum(:file_file_size)
  end

  def expired?
    DateTime.now >= self.expires_at
  end

  private
    def generate_token
      self.token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless User.exists?(token: random_token)
      end
    end
 
  def set_expiration
    self.expires_at = DateTime.now+365
  end

    def default_role
      self.role = "user"
    end
end
