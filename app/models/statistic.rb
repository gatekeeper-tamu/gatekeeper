class Statistic < ApplicationRecord

def self.total_cost_all_subscriptions
  #calculate sum of all subscriptions
  sum = 0
  for sub in Subscription
    sum += sub.cost_per_month
  end
  return sum
end

end