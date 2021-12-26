require 'rails_helper'

RSpec.describe Chapter, type: :model do
  it { should belong_to(:course) }
  it { should have_many(:lessons) }

  it { should validate_presence_of(:title) }
end
