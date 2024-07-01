FactoryBot.define do
  factory :item do
    product_name           { Faker::Commerce.product_name }
    explanation            { Faker::Lorem.sentence }
    category_id            { 2 }
    condition_id           { 2 }
    delivery_charge_id     { 2 }
    shipping_source_id     { 2 }
    date_of_shipment_id    { 2 }
    price                  { Faker::Number.between(from: 300, to: 9_999_999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('public/images/test_image.png')), filename: 'test_image.png')
    end
  end
end

