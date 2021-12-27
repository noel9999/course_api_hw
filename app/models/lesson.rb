class Lesson < ApplicationRecord
  belongs_to :chapter
  validates :title, :content, presence: true
  validates :order, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
