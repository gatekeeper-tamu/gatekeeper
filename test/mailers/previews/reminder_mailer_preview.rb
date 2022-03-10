# Preview all emails at http://localhost:3000/rails/mailers/reminder_mailer

class ReminderMailerPreview < ActionMailer::Preview
    def new_reminder_email
        reminder = Reminder.new(subscription_id: "1234", reminder_id: "5678", time_delta: "3", recurring: true, message:"Your Netflix subscription is expiring in 1 week.")

        ReminderMailer.with(reminder: reminder).new_reminder_email
    end
end
