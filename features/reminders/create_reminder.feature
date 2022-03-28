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
		| Google			å	| anothertest   | RidleyScott	| google.com	| 8.99				|

    Scenario: User can see the new reminder form
	    Given I am on the homepage
		When I view the "Netflix" subscription
		And I click the "Create Reminder" button
  		Then I should see the new reminder page

	Scenario: User create a reminder successfully
		Given I am on the reminders "new" page for "Netflix" subscription
		When I create a new reminder for "Netflix" subscription
		And I click the "Create Reminder" button
  		Then I should see the reminder's show page
