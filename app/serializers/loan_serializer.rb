class LoanSerializer < ActiveModel::Serializer
  attributes :id, :friend_email, :friend_name, :loaned_item, :created_at

  def id
    object.id.to_s
  end
end
