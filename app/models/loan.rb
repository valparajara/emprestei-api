class Loan
  include Mongoid::Document
  include Mongoid::Timestamps::Created

  field :email, type: String
  field :loaned_item, type: String
  field :returned, type: Mongoid::Boolean
  field :returned_at, type: Date

  validates :email, presence: true
  validates :loaned_item, presence: true

  before_save :check_if_return_lent

  embedded_in :user

  private

  def check_if_return_lent
    if returned_changed?
      self.returned_at = Date.today
    end
  end
end
