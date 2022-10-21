FactoryBot.define do
  factory :invoice do
    status {Faker::Number.within(range: 1..2)}
    customer
  end
end
