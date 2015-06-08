class LoanSerializer < ActiveModel::Serializer
  attributes :id, :email, :loaned_item

  def id
    object.id.to_s
  end
end
