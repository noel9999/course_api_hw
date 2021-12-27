require 'rails_helper'

RSpec.describe Lesson, type: :model do
  it { should belong_to(:chapter) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should validate_numericality_of(:order).is_greater_than_or_equal_to(0).only_integer }
end
