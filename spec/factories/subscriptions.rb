require 'faker'

FactoryBot.define do
  factory :subscription do |f|
    f.subscription_name { Faker::Company.name }
	f.user { association :user }
	f.username { Faker::Name.first_name.downcase.to_s }
	f.password { Faker::Alphanumeric.alphanumeric(number: 10) }
	f.url { Faker::Internet.url }
  end
end