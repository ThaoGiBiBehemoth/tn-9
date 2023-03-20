class TaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :status, :deadline 
  has_many :items
  # has_one :User
end
