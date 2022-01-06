def create_user
	@visitor ||= {
		:email    => "manny@testerman.com",
		:first_name => "Manny",
		:last_name => "Testerman",
		:password => "awesome",
		:password_confirmation => "awesome"
		}
end

def sign_in 
    fill_in "user_email", :with => @visitor[:email]
    fill_in "user_password", :with => @visitor[:password]
    click_button "Log in"
end

##### GIVEN #####
Given(/^I am on the homepage$/) do
	visit "/"
end
Given /^I am on sign in page$/ do
	visit "/users/sign_in"
end

##### WHEN #####
When /^I click "(.*?)"$/ do |button|
	click_button(button)
end
When /^I sign up with valid user data$/ do
	create_user 
end
When /^I login with valid user data$/ do
	create_user
	sign_in
end


##### THEN #####
Then /^I am on the sign in page$/ do
	visit "/users/sign_in"
end
Then /^I should see a successful login message$/ do
	pending
end
	