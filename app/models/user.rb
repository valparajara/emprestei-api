class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email,              type: String, default: ""
  field :crypted_password,   type: String, default: ""
  field :token_acesso,       type: Integer

  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  embeds_many :loans

  validates :email, presence: true, uniqueness: true
end
