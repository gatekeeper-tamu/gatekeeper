json.extract! subscription, :id, :user, :subscription_name, :username, :password, :url, :cost_per_month, :image, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)
