class Lesson < ApplicationRecord
  belongs_to :chapter
  validates :title, :content, presence: true
end
