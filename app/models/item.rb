class Item < ApplicationRecord
  belongs_to :task
  validates :title,   presence: true, length: {maximum: 50}
  validates :descrip, presence: true, length: {maximum: 250}
end
