Feature: Create Reminder
	As an existing user
    I want to be able to create reminders
    So that I can receive emails reminders for my subscriptions
	
	Background: users have subscriptions
		Given the test users exist
		And I am logged in
		And the following subscriptions exist for user with email "manny@testerman.com":
		| subscription_name     | username		| password		| url			| cost_per_month	|
		| Netflix			    | test     		| supersecure	| netflix.com	| 9.95				|
		| Google			 	| anothertest   | RidleyScott	| google.com	| 8.99				|

    Scenario: User can see the new reminder form
	    Given I am on the homepage
		When I view the "Netflix" subscription
		And I click the "Create Reminder" button
  		Then I should see the reminder "new" page

    Scenario: Users can see the frequency options for recurring reminders
		Given I am on the reminders "new" page for "Netflix" subscription
		When I select "Yes" for reminder recurring
  		Then I should see the frequency options

	Scenario: Users cannot see the frequency options for non-recurring reminders
		Given I am on the reminders "new" page for "Netflix" subscription
		When I select "No" for reminder recurring
  		Then I should not see the frequency options

	Scenario: User creates a reminder successfully
		Given I am on the reminders "new" page for "Netflix" subscription
		When I create a new reminder for "Netflix" subscription
		And I click the "Create Reminder" button
 		Then I should see the reminder "show" page

	Scenario: User creates a recurring reminder successfully
		Given I am on the reminders "new" page for "Google" subscription
		When I create a new recurring reminder for "Google" subscription 
		And I click the "Create Reminder" button
  		Then I should see the reminder "show" page

	Scenario: User creates a reminder unsuccessfully with an invalid date
		Given I am on the reminders "new" page for "Netflix" subscription
		When I create a new reminder for "Netflix" subscription with an invalid date
		And I click the "Create Reminder" button
  		Then I should see an error






