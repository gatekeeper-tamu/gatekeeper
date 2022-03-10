Feature: View Subscription
	As an existing user
    I want to be able to view subscriptions
    So that I can see usernames and passwords on Gatekeeper

	Background: users have subscriptions
		Given the test users exist
		And I am logged in
		And the following subscriptions exist for user with email "manny@testerman.com":
		| subscription_name     | username		| password		| url			| cost_per_month	|
		| Netflix			    | test     		| supersecure	| netflix.com	| 9.95				|
		| Google				| anothertest   | RidleyScott	| google.com	| 8.99				|
		And the following subscriptions exist for user with email "sarah@testerwoman.com":
		| subscription_name     | username		| password		| url			| cost_per_month	|
		| Hulu				    | test     		| supersecure	| Hulu.com		| 9.95				|

    Scenario: Signed in user sees subscription homepage
	    Given I am on the homepage
  		Then I should see my subscriptions

    Scenario: User views a subscription successfully
	    Given I am on the homepage
		When I view the "Netflix" subscription
  		Then I should see the subscription's show page
	
    Scenario: User tries to view another user's subscription
	    Given I am on the homepage
		When I view the "Hulu" subscription
  		Then I should see the resource not found page
	
    Scenario: Unauthenticated user tries to view a subscription
		Given I am not logged in
		When I view the "Netflix" subscription
  		Then I am on the sign in page
