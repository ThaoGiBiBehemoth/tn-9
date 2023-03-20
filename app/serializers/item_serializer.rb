class ItemSerializer < ActiveModel::Serializer
  attributes :id, :title, :descrip, :status, :deadline
  has_one :task
end
