FactoryBot.define do
  factory :user do
    nickname { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { 'password1' }
    password_confirmation { 'password1' }
    family_name { '山田' }
    first_name { '太郎' }
    family_name_kana { 'ヤマダ' }
    first_name_kana { 'タロウ' }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
  end
end
