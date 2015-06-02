class Loan
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :email, type: String
  field :item_lent, type: String

  validates :email, presence: true
  validates :item_lent, presence: true
end
