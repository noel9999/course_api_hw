class Course < ApplicationRecord
  has_many :chapters

  validates :title, :mentor_title, presence: true
  validates :title, uniqueness: true
end
