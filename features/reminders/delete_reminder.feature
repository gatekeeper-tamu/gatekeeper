Feature: Delete Reminder
	As an existing user
    I want to be able to delete reminders
    So that I can remove unnecessary reminders when they expire

	Background: users have reminders
		Given I am logged in
		And the following subscriptions exist for user with email "manny@testerman.com":
		| subscription_name     | username		| password		| url			| cost_per_month	|
		| Netflix			    | test     		| supersecure	| netflix.com	| 9.95				|
		| Google				| anothertest   | RidleyScott	| google.com	| 8.99				|
		And the following reminders exist for "Netflix" subscription:
		| recurring             | reminder_type		| notification_time	| end_date		| 
		| Yes       		    | Billing     		| 3 days before		| 26-04-2022	| 
		| Yes				    | Cancellation      | 1 day before		| 26-04-2022	| 
			
    Scenario: User deletes a subscription successfully
	    Given I am on the homepage
		When I view the "Netflix" subscription
		And I delete a reminder for "Netflix"
  		Then the reminder should not exist