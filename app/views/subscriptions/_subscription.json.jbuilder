json.extract! subscription, :id, :name, :category, :end_date, :sub_username, :sub_password, :monthly_cost, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)
