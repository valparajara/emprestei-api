class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  has_secure_password

  field :email,              type: String, default: ""
  field :access_token,        type: String
  field :password_digest,    type: String

  embeds_many :loans

  VALID_EMAIL_FORMAT= /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates :email, presence: true, length: {maximum: 100}, format: { with: VALID_EMAIL_FORMAT}, uniqueness: true

  before_validation { self.email = email.downcase.strip if email.present? }

  before_create :generate_auth_tokens

  class << self

    def auth_user(params)
      user = User.where(email: params[:email]).first
      user.authenticate(params[:password]) if user.present?
    end
  end

  def generate_auth_tokens
    auth_token = SecureRandom.hex
    self.access_token = auth_token
  end

end
