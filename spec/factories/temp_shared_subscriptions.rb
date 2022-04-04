FactoryBot.define do
  factory :temp_shared_subscription do
    end_date { "2025-04-03" }
    subscription { association :subscription }
  end
end
