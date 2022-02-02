json.extract! reminder, :id, :subscription_id, :reminder_id, :time_delta, :recurring, :message, :created_at, :updated_at
json.url reminder_url(reminder, format: :json)
