FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.between(1..100) }
    unit_price { Faker::Number.between(1..100) }

    item
    invoice
  end
end
