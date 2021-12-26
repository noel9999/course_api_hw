class Course < ApplicationRecord
  has_many :chapters, -> { order(:order, :id) }, dependent: :destroy, inverse_of: :course
  has_many :lessons, through: :chapters

  validates :title, :mentor_title, presence: true
  validates :title, uniqueness: true
  validates_associated :chapters

  accepts_nested_attributes_for :chapters, allow_destroy: true, reject_if: :all_blank
end
