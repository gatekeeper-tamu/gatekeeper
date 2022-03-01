require 'faker'

FactoryGirl.define do
  factory :group do
    group_name { Faker::Company.name }
	  owner { association :user }
    factory :group_with_members do
      users { [association(:user), association(:user), association(:user)]}
    end
    factory :group_with_subscriptions do
      subscriptions { [association(:subscription), association(:subscription), association(:subscription)]}
    end
  end
end