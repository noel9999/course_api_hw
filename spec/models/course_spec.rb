require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should have_many(:chapters) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :mentor_title }
  it { should validate_uniqueness_of :title }
end
