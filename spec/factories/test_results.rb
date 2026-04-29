FactoryBot.define do
  factory :test_result do
    student_name { Faker::Name.name }
    subject { "Math" }
    marks { rand(30..100) }
    timestamp { Time.current }
  end
end
