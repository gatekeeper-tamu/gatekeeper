Feature: Delete Subscription
	As an existing user
    I want to be able to delete subscriptions
    So that I can remove usernames and passwords from Gatekeeper

	Background: users have subscriptions
		Given I am logged in
		And the following subscriptions exist for user with email "manny@testerman.com":
		| subscription_name     | username		| password		| url			| cost_per_month	|
		| Netflix			    | test     		| supersecure	| netflix.com	| 9.95				|
		| Google				| anothertest   | RidleyScott	| google.com	| 8.99				|
		
    Scenario: User deletes a subscription successfully
	    Given I am on the homepage
		When I view the "Netflix" subscription
		And I click the "Delete" button
  		Then the "Netflix" subscription should not exist
	
    Scenario: User tries to view a deleted subscription
	    Given I am on the homepage
		When I view the "Netflix" subscription
		And I click the "Delete" button
		And I view the "Netflix" subscription
  		Then I should see the resource not found page
