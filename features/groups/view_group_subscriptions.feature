Feature: View Group Subscription
	As an existing user
    I want to be able to view subscriptions from my groups
    So that I can see shared usernames and passwords on Gatekeeper

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
		And the following groups exist for user with email "sarah@testerwoman.com":
		| group_name	|
		| Test Family	| 
		And the following subscriptions and users exist for the "Test Family" group:
		| subscription_name	| user_email            |
		| Hulu          	| manny@testerman.com   |

    Scenario: Signed in user sees group subscriptions on homepage
	    Given I am on the homepage
  		Then I should see my group subscriptions
