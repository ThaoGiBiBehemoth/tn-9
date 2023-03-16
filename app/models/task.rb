class Task < ApplicationRecord
  belongs_to :user
  has_many :items
  validates :title,   presence: true, length: {maximum: 50}
end
