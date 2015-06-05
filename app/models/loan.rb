class Loan
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :email, type: String
  field :item_lent, type: String
  field :returned, type: Boolean
  field :returned_at, type: Date

  validates :email, presence: true
  validates :item_lent, presence: true

  before_save :check_if_return_lent

  embedded_in :user

  private

  def check_if_return_lent
    if returned_changed?
      self.returned_at = Date.today
    end
  end
end
