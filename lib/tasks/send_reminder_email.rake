namespace :send_reminder_email do
    desc 'Sends a reminder email to user to address reminder type'
    task days: :environment do
        puts Date.today
        User.all.each do |user|
            user.subscriptions.all.each do |subscription|
                subscription.reminders.all.each do |reminder|
                    #for each reminder, check if the end date and calculate date to send reminder
                    endDate = reminder.end_date
                    reminderDate = endDate - reminder.time_delta
                    puts reminderDate
                    if reminderDate == Date.today
                        puts "Reminder date today"
                        ReminderMailer.with(user: user, reminder: reminder).new_reminder_email.deliver_now
                    end
                end
            end
        end
        puts "End emails"
    end
end
