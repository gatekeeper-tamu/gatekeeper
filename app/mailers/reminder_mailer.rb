class ReminderMailer < ApplicationMailer

    def new_reminder_email
        @reminder = params[:reminder]

        mail(to: 'gatekeeper.tamu@gmail.com', subject: "DIS WORK")
    end
end
