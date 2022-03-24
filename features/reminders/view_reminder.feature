Feature: View Reminder
	As an existing user
    I want to be able to view reminders
    So that I know which of my subscriptions have reminders

	Background: users have reminders
		Given I am logged in
		And the following subscriptions exist for user with email "manny@testerman.com":
		| subscription_name     | username		| password		| url			| cost_per_month	|
		| Netflix			    | test     		| supersecure	| netflix.com	| 9.95				|
		| Google				| anothertest   | RidleyScott	| google.com	| 8.99				|
		And the following reminders exist for "Netflix" subscription:
		| recurring             | reminder_type		| time_delta	| end_date		| 
		| Yes       		    | Billing     		| 3 days before	| 26-04-2022	| 
		| Yes				    | Cancellation      | 1 day before	| 26-04-2022	| 
		
    Scenario: User views a reminder successfully
	    Given I am on the homepage
		When I view the "Netflix" subscription
  		Then I should see reminders for the "Netflix" subscription
	
    Scenario: Unauthenticated user tries to view a reminder
		Given I am not logged in
		When I view the "Netflix" subscription
  		Then I am on the sign in page
