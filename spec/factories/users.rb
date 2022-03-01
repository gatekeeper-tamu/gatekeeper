require 'faker'

FactoryBot.define do
  factory :user do |f|
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.username { Faker::Internet.email.split("@").first}
    f.password {Faker::Alphanumeric.alphanumeric(number: 10) }
    f.email { Faker::Internet.email}
  end
end