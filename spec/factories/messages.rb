FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    user
    lesson
  end
end