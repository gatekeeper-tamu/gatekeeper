Feature: Sign out of account
	As an existing user
    I want to be able to sign out of my account
    So that my account is protected from unauthorized access
	
    Scenario: User creates account successfully
	    Given I am logged in
        When I sign out
        Then I should see a successful logout message
        Then I return to the site
