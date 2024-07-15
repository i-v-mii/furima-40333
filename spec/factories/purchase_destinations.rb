FactoryBot.define do
  factory :purchase_destination do
    post_code { '123-4567' }
    shipping_source_id { 2 }
    municipality { 'Sample City' }
    street_address { 'Sample Street 1-1' }
    building_name { 'Sample Building' }
    tel { '09012345678' }
  end
end