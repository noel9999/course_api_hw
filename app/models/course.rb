class Course < ApplicationRecord
  validates :title, :mentor_title, presence: true
  validates :title, uniqueness: true
end
