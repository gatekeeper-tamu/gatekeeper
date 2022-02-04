def create_user(email, first, last, username, password)
	return {
		:email    => email,
		:first_name => first,
		:last_name => last,
		:username => username,
		:password => password,
		:password_confirmation => password
	}
end

def register_user(visitor_info)
	delete_user(visitor_info)
	User.create visitor_info
	return find_user(visitor_info[:email])
end

def create_test_users
	@visitor = register_user(create_user("manny@testerman.com", "Manny", "Testerman", "mannyt", "awesome"))
	@visitor2 = register_user(create_user("sarah@testerwoman.com", "Sarah", "Testerwoman", "saraht", "supersecure"))
end

def delete_user(visitor_info)
	# puts visitor_info
	user = User.where(:email => visitor_info[:email]).first
	user.destroy unless user.nil?
end

def find_user(email)
	user ||= User.where(:email => email).first
end

def check_path(page_name)
	expected = path_to(page_name)
	actual = URI.parse(current_url).path
	wait_until { actual == expected }
end

##### GIVEN #####
Given(/^I am on the homepage$/) do
	visit "/"
end

Given(/^the test users exist$/) do
	create_test_users
end


##### WHEN #####
When /^I click the "(.*)" link$/ do |link_name|
	click_link link_name
end

When /^I click the "(.*)" button$/ do |button_name|
	click_button button_name
end


##### THEN #####
Then /^I should see the resource not found page$/ do
	page.should have_content("The page you were looking for doesn't exist.")
end
