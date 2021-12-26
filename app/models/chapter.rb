class Chapter < ApplicationRecord
  belongs_to :course
  has_many :lessons

  validates :title, presence: true
  validates_associated :lessons

  accepts_nested_attributes_for :lessons, allow_destroy: true, reject_if: :all_blank
end
