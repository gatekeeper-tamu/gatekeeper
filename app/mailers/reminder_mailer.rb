class ReminderMailer < ApplicationMailer

    def new_reminder_email
        @reminder = params[:reminder]

        ##set up logic for how frequent we want the email sent here

        mail(to: 'gatekeeper.tamu@gmail.com', subject: "[GATEKEEPER REMINDER] One of your subscriptions is ending soon")
    end
end
