class Chapter < ApplicationRecord
  belongs_to :course
  has_many :lessons, -> { order(:order, :id) }, dependent: :destroy, inverse_of: :chapter

  validates :title, presence: true
  validates :order, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # we may move this to some kind of form object in the future in order to stay the basic but valid validations in this model, otherwise it might cause some cost when maniplating this object
  validates_associated :lessons

  accepts_nested_attributes_for :lessons, allow_destroy: true, reject_if: :all_blank
end

