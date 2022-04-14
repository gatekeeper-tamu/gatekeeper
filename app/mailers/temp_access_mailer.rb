class TempAccessMailer < ApplicationMailer
    def share_subscription_email(share_record, subscription, email, user)
		@share_record = share_record
        @sub = subscription
        @user = user
        mail(to: email, subject: "Temporary Account Access on Gatekeeper")
        puts "Sent temp access email to #{email}"
    end
end
