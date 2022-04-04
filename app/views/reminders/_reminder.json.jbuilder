json.extract! reminder, :id, :recurring, :reminder_type, :notification_time, :frequency, :end_date, :created_at, :updated_at
json.url reminder_url(reminder, format: :json)
