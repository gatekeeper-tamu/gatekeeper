module ControllerMacros
	def login_user
	  # Before each test, create and login the user
	  before(:each) do
		@request.env["devise.mapping"] = Devise.mappings[:user]
		current_user = User.first_or_create!(username: 'test', email: 'dean@example.com', password: 'password')

		sign_in current_user
	  end
	end
  end