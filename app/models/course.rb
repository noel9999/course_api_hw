class Course < ApplicationRecord
  has_many :chapters, -> { order(:order, :id) }, dependent: :destroy, inverse_of: :course
  has_many :lessons, through: :chapters

  validates :title, :mentor_title, presence: true
  validates :title, uniqueness: true

  # we may move this to some kind of form object in the future in order to stay the basic but valid validations in this model, otherwise it might cause some cost when maniplating this object
  validates_associated :chapters

  accepts_nested_attributes_for :chapters, allow_destroy: true, reject_if: :all_blank
end
