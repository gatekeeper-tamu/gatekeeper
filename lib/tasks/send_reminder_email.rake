namespace :send_reminder_email do
    desc 'Sends a reminder email to user to address reminder type'
    task days: :environment do
        User.all.each do |user|
            user.subscriptions.all.each do |subscription|
                subscription.reminders.all.each do |reminder|
                    #for each reminder, check if the end date and calculate date to send reminder
                    reminderDate = reminder.end_date - reminder.notification_time
                    
                    if reminderDate == Date.today
                        puts "Reminder date today, sending email"
                        ReminderMailer.with(user: user, reminder: reminder).new_reminder_email.deliver_now

                        if reminder.recurring == true
                            puts "setting new end_date"
                            #check to reset end_date for recurring reminders
                            if reminder.frequency == 'Weekly'
                                reminder.end_date = reminder.end_date + 7
                            elsif reminder.frequency == 'Monthly'
                                reminder.end_date = reminder.end_date + 30
                            elsif reminder.frequency == 'Annually'
                                reminder.end_date = reminder.end_date + 365
                            end
                            puts reminder.end_date
                        else
                            #destroy inactive reminders
                            puts "destroying reminder", reminder.id
                            Reminder.destroy(reminder.id)                            
                        end

                        #check for outdated reminders
                        if reminder.end_date < Date.today
                            Reminder.destroy(reminder.id)                            
                        end
                    end
                end
            end
        end
        puts "Finished."
    end
end
