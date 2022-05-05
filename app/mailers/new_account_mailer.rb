class NewAccountMailer < ApplicationMailer
	def new_account_email(user)
		#send an email to gatekeeper.tamu@gmail.com whenever a new Gatekeeper account is created.
		@new_user = user
		mail(to: 'gatekeeper.tamu@gmail.com', subject: "New Account for Gatekeeper!")
	end
end
