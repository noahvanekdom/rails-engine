FactoryBot.define do
  factory :invoice_item do
    quantity { Faker::Number.between(from: 0, to: 50) }
    unit_price { Faker::Number.between(from: 0.00, to: 100.00) }

    item
    invoice
  end
end
