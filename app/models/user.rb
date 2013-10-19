class User < ActiveRecord::Base
  attr_accessible :username, :password

  before_validation :ensure_session_token!

  validates :username, :session_token, :presence => true
  validates :username, :uniqueness => true
  validates :password_digest, :presence => {:message => "Password can't be blank"}

  has_many(
  :goals,
  :class_name => "Goal",
  :foreign_key => :author_id,
  :primary_key => :id
  )

  has_many :cheers

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)

    if user.nil?
      return nil
    else
      user.is_password?(password) ?  user : nil
    end
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save
    self.session_token
  end

  def password=(pass)
    self.password_digest = BCrypt::Password.create(pass)
  end

  def is_password?(pass)
    BCrypt::Password.new(self.password_digest).is_password?(pass)
  end

  def cheers_today
    self.cheers.select { |cheer| cheer.created_at.today? }.count
  end

  private

  def ensure_session_token!
    self.session_token ||= self.class.generate_session_token
  end
end
