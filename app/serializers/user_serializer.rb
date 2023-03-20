class UserSerializer < ActiveModel::Serializer
  attributes :id, :nickname, :email #, :password_digest, :created_at, :updated_at
  # has_many :tasks
end
