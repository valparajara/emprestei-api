class Loan
  include Mongoid::Document
  include Mongoid::Timestamps

  field :friend_email, type: String
  field :friend_name, type: String
  field :loaned_item, type: String
  field :notification, type: Integer, default: 1

  field :returned, type: Mongoid::Boolean
  field :returned_at, type: Date

  validates :friend_email, presence: true
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
