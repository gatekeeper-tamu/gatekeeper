require 'faker'

FactoryBot.define do
  factory :reminder do 
    recurring { Faker::Boolean.trust }
    reminder_type { "Billing" }
    time_delta { "2 days before" }
    end_date  { Faker::Date.between(from: '2022/01/01', to: '2023/12/31').strftime("%d/%m/%Y") }
    subscription { association :subscription }
  end
end
