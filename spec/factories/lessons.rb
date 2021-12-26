FactoryBot.define do
  factory :lesson do
    association :chapter, factory: :chapter
    title { Faker::Movies::StarWars.specie }
    content { Faker::Movies::StarWars.wookiee_sentence }
  end
end
