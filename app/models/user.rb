class User < ActiveRecord::Base
  attr_accessible :user_name, :password

  before_validation(:on => :create) do
    check_session_token
  end
  validates :user_name, :password_digest, :session_token, :presence => true
  validates :user_name, :session_token, :uniqueness => true

  def reset_session_token!
    self.session_token = SecureRandom.base64
  end

  def check_session_token
    if self.session_token.nil?
      reset_session_token!
    end
  end

  def password=(str)
    @password = str #validate password later for length...
    self.password_digest = BCrypt::Password.create(str)
  end

  def is_password?(str)
    BCrypt::Password.new(self.password_digest).is_password?(str)
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by_user_name(user_name)
    return nil if user.nil?
    return user if user.is_password?(password)
  end
end
