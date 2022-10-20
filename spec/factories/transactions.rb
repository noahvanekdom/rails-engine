FactoryBot.define do
  factory :transaction do
    credit_card_number { Faker::Number.number(digits: 16) }

    ##come back to add faker here
    credit_card_expiration_date { "10/29" }
    result { "success" }
    invoice
  end
end
