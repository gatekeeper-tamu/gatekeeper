require 'faker'

FactoryBot.define do
  factory :reminder do 
    recurring { Faker::Boolean.trust }
    reminder_type { "Billing" }
    notification_time { "2 days before" }
    frequency { "Monthly" }
    end_date  { Faker::Date.between(from: '2022/01/01', to: '2023/12/31').strftime("%d/%m/%Y") }
    subscription { association :subscription }
  end
end
