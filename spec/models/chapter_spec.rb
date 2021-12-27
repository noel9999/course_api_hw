require 'rails_helper'

RSpec.describe Chapter, type: :model do
  it { should belong_to(:course) }
  it { should have_many(:lessons) }

  it { should validate_presence_of(:title) }
  it { should validate_numericality_of(:order).is_greater_than_or_equal_to(0).only_integer }
end
