Feature: Log into account
	As an existing user
    I want to be able to login with my credentials
    So that I can access my profile
	
    Scenario: User signs in successfully
		Given I am on sign in page
		When I login with valid user credentials
  		Then I should see the profile page

	Scenario: User does not exist
		Given I do not exist as a user
		And I am on sign in page
		When I login with valid user credentials
		Then I should see a "User does not exist" message

	Scenario: User enters wrong email
		Given I exist as a user
		And I am on sign in page
		When I login with a wrong email
		Then I should see a "Incorrect email or password" message

	Scenario: User enters wrong password
		Given I exist as a user
		And I am on sign in page
		When I login with a wrong password
		Then I should see a "Incorrect email or password" message
