Feature: Create and log into account
	As a non-existing user
    I want to be able to create an account with login credentials
    So that I can have my own profile
	
	Background:
		Given I am on sign in page

    Scenario: User creates account successfully
		When I sign up with valid user credentials
  		Then I should see a successful login message
	
	Scenario: User signs up with invalid email
		When I sign up with an invalid email
  		Then I should see an invalid sign up message
	
	Scenario: User signs up without password
		When I sign up without a password
  		Then I should see an invalid sign up message

	Scenario: User signs up without password confirmation
		When I sign up without a password confirmation
  		Then I should see an invalid sign up message

		Scenario: User signs up with mismatched password and password confirmation
		When I sign up with up a mismatched password and password confirmation
  		Then I should see an invalid sign up message