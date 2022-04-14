class NewAccountMailer < ApplicationMailer
	def new_account_email(user)
		@new_user = user
		mail(to: 'gatekeeper.tamu@gmail.com', subject: "New Account for Gatekeeper!")
	end
end
