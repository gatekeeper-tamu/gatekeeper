Feature: Create and log into account
	As a non-existing user
    I want to be able to create an account with login credentials
    So that I can have my own profile
	
    Scenario: User creates account successfully
		Given I am on sign in page
		When I sign up with valid user data
  		Then I should see a successful login message
