FactoryBot.define do
  factory :company do
    zip_code { Faker::Number.number(digits: 5) }
    email { "#{Faker::Name.unique.name.gsub(" ","")}@getmainstreet.com" }
  end
end
