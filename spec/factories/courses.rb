FactoryBot.define do
  factory :course do
    title { Faker::Name.unique.name }
    mentor_title { Faker::Movies::StarWars.character }
    description { Faker::Movies::StarWars.quote }
    trait(:with_chapters) do
      after(:create) do |course|
        2.times do
          create(:chapter, :with_lessons, course: course)
        end
      end
    end
  end
end
