FactoryBot.define do
  factory :chapter do
    association :course, factory: :course
    title { Faker::Movies::StarWars.planet }
  end
end
