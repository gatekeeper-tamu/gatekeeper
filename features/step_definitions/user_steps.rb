def create_visitor
	@visitor_info ||= {
		:email    => "manny@testerman.com",
		:first_name => "Manny",
		:last_name => "Testerman",
		:username => "mannyt",
		:password => "awesome",
		:password_confirmation => "awesome"
	}
	@user = register_user(@visitor_info)
end

def sign_in(visitor_info)
    fill_in "user_email", :with => visitor_info[:email]
    fill_in "user_password", :with => visitor_info[:password]
    click_button "Log in"
	@user = find_user(visitor_info[:email])
end

def sign_up(visitor_info)
	delete_user(visitor_info)
	visit '/users/sign_up'
	fill_in "user_first_name", :with => visitor_info[:first_name]
	fill_in "user_last_name", :with => visitor_info[:first_name]
	fill_in "user_email", :with => visitor_info[:email]
	fill_in "user_username", :with => visitor_info[:username]
	fill_in "user_password", :with => visitor_info[:password]
	fill_in "user_password_confirmation", :with => visitor_info[:password_confirmation]
	click_button "Sign up"
	@user = find_user(visitor_info[:email])
  end

def sign_out
	visit "/"
	click_link "Sign Out"
	page.has_content?("Sign Up")
	page.has_content?("Sign In")
end

##### GIVEN #####
Given /^I am on sign in page$/ do
	visit "/users/sign_in"
end
Given /^I do not exist as a user$/ do
	create_visitor
	delete_user(@visitor_info)
end
Given /^I exist as a user$/ do
	create_visitor
end
Given /^I am not logged in$/ do
	sign_out
end
Given /^I am logged in$/ do
	create_visitor
	visit "/users/sign_in"
	sign_in(@visitor_info)
	page.has_content?("Sign out")
end
Given(/^I am on my profile page$/) do
	expect(@user.nil? == false)
	visit "/users/#{@user.username}"
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
	sign_up(@visitor_info)
end
When /^I sign up with an invalid email$/ do
	create_visitor
	test_info = @visitor_info.merge(:email => "notanemail")
	sign_up(test_info)
end
When /^I sign up without a password$/ do
	create_visitor
	test_info = @visitor_info.merge(:password => "")
	sign_up(test_info)
end
When /^I sign up without a password confirmation$/ do
	create_visitor
	test_info = @visitor_info.merge(:password_confirmation => "")
	sign_up(test_info)
end
When /^I sign up with up a mismatched password and password confirmation$/ do
	create_visitor
	test_info = @visitor_info.merge(:password_confirmation => "dis_do_be_wrong")
	sign_up(test_info)
end

When /^I login with valid user credentials$/ do
	sign_in(@visitor_info)
end
When /^I login with a wrong email$/ do
	testvisitor = @visitor
	test_info = @visitor_info.merge(:email => "notanemail")
	sign_in(test_info)
end
When /^I login with a wrong password$/ do
	testvisitor = @visitor
	test_info = @visitor_info.merge(:password => "wrongpassword")
	sign_in(test_info)
end 



##### THEN #####
Then /^I am on the sign in page$/ do
	expect(page).to have_current_path("/users/sign_in", wait: true)
end
Then /^I should see the profile page$/ do
	expect(page).to have_current_path("/subscriptions", wait: true)
	# user = User.where(username: @visitor_info[:username])
	path = "/users/#{@user.username}"
	visit path
	page.has_content?(@user.first_name)
	page.has_content?(@user.last_name)
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