def create_visitor
	@visitor ||= {
		:email    => "manny@testerman.com",
		:first_name => "Manny",
		:last_name => "Testerman",
		:username => "mannytesterman",
		:password => "awesome",
		:password_confirmation => "awesome"
	}
end

def delete_user
	@user ||= User.where(:email => @visitor[:email]).first
	@user.destroy unless @user.nil?
end

def create_user
	create_visitor
	delete_user 
	User.create @visitor
	find_user
	# @user = FactoryBot.create(:user, **@visitor)
end

def sign_in 
    fill_in "user_email", :with => @visitor[:email]
    fill_in "user_password", :with => @visitor[:password]
    click_button "Log in"
	find_user
end

def sign_up
	delete_user
	visit '/users/sign_up'
	fill_in "user_first_name", :with => @visitor[:first_name]
	fill_in "user_last_name", :with => @visitor[:first_name]
	fill_in "user_email", :with => @visitor[:email]
	fill_in "user_username", :with => @visitor[:email]
	fill_in "user_password", :with => @visitor[:password]
	fill_in "user_password_confirmation", :with => @visitor[:password_confirmation]
	click_button "Sign up"
	find_user
  end

def sign_out
	visit "/"
	if page.text.match?("Sign out")
		click_link "Sign out"
	end
end

def find_user
	@user ||= User.where(:email => @visitor[:email]).first
	# puts "User: #{@user}"
end

##### GIVEN #####
Given(/^I am on the homepage$/) do
	visit "/"
end
Given /^I am on sign in page$/ do
	visit "/users/sign_in"
end
Given /^I do not exist as a user$/ do
	create_user
	delete_user
end
Given /^I exist as a user$/ do
	create_user
end
Given /^I am not logged in$/ do
	sign_out
end
Given /^I am logged in$/ do
	create_user
	visit "/users/sign_in"
	sign_in
end


##### WHEN #####
When /^I click the login button$/ do
    click_button "LOGIN"
end

When /^I sign out$/ do
	sign_out
end
When /^I sign up with valid user credentials$/ do
	create_visitor
	sign_up
end
When /^I sign up with an invalid email$/ do
	create_user
	@visitor = @visitor.merge(:email => "notanemail")
	sign_in
end
When /^I sign up without a password$/ do
	create_user
	@visitor = @visitor.merge(:password => "")
	sign_in
end
When /^I sign up without a password confirmation$/ do
	create_user
	@visitor = @visitor.merge(:password_confirmation => "")
	sign_in
end
When /^I sign up with up a mismatched password and password confirmation$/ do
	create_user
	@visitor = @visitor.merge(:password_confirmation => "dis_do_be_wrong")
	sign_in
end

When /^I login with valid user credentials$/ do
	create_user
	sign_in
end
When /^I login with a wrong email$/ do
	@visitor = @visitor.merge(:email => "notanemail")
	sign_in
end
When /^I login with a wrong password$/ do
	@visitor = @visitor.merge(:password => "notapassword")
	sign_in
end 



##### THEN #####
Then /^I am on the sign in page$/ do
	visit "/users/sign_in"
end
Then /^I should see the profile page$/ do
	path = "/users/" + @user[:email].split("@").first
	visit path	
end
Then /^I should see a "(.*?)" message$/ do |error_message|
	page.has_content?(error_message)
end
Then /^I should see a successful logout message$/ do
	page.has_content?("Successfully logged out. Bye!")
end
Then /^I return to the site$/ do
	visit "/"
end