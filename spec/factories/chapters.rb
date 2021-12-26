FactoryBot.define do
  factory :chapter do
    association :course, factory: :course
    title { Faker::Movies::StarWars.planet }
    trait(:with_lessons) do
      after(:create) do |chapter|
        2.times do
          create(:lesson, chapter: chapter)
        end
      end
    end
  end
end
