class LoanSerializer < ActiveModel::Serializer
  attributes :id, :email, :item_lent

  def id
    object.id.to_s
  end
end
