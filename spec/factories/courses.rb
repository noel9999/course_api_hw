FactoryBot.define do
  factory :course do
    title { Faker::Name.unique.name }
    mentor_title { Faker::Movies::StarWars.character }
    description { Faker::Movies::StarWars.quot }
  end
end
