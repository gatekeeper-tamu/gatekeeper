Feature: Log into account
	As an existing user
    I want to be able to login with my credentials
    So that I can access my profile
	
    Scenario: User creates account successfully
		Given I am on sign in page
		When I login with valid user data
  		Then I should see a successful login message
