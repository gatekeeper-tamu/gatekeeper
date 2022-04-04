namespace :send_reminder_email do
    desc 'Sends a reminder email to user to address reminder type'
    task days: :environment do

        User.all.each do |user|
            puts "Start"
            user.subscriptions.all.each do |subscription|
                subscription.reminders.all.each do |reminder|
                    #for each reminder, check if the end date and calculate date to send reminder
                    endDate = reminder.end_date
                    reminderDate = endDate - reminder.notification_time
                    puts reminderDate
                    if reminderDate == Date.today
                        puts "Reminder date today, sending email"
                        #ReminderMailer.with(user: user, reminder: reminder).new_reminder_email.deliver_now

                        if reminder.recurring == true
                            #check to reset end_date for recurring reminders
                            if reminder.frequency == 'Weekly'
                                reminder.end_date = reminder.end_date + 7
                            elsif reminder.frequency == 'Monthly'
                                reminder.end_date = reminder.end_date + 30
                            elsif reminder.frequency == 'Annually'
                                reminder.end_date = reminder.end_date + 365
                            end
                            puts "new end_date"
                            puts reminder.end_date
                        end
                    end
                end
            end
        end
        puts "End emails"
    end
end
