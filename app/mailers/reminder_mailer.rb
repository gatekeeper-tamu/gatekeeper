class ReminderMailer < ApplicationMailer
    def new_reminder_email
        @reminder = params[:reminder]
        @user = params[:user]
        #sends reminder email at the scheduled time
        mail(to: @user.email, subject: "[GATEKEEPER REMINDER] Check on your #{@reminder.subscription.subscription_name} Subscription!")
        puts "Email sent to" + @user.email + " for " + @reminder.reminder_type
    end
end
