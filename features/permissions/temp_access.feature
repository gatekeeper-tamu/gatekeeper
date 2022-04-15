Feature: Permissions for Groups and Subscriptions
	As an existing user
    I want to be able to create temporary access links for my subscriptions

	Background: users have subscriptions and groups
		Given the test users exist
		And I am logged in
		And the following subscriptions exist for user with email "manny@testerman.com":
		| subscription_name     | username		| password		| url			| cost_per_month	|
		| Hulu				    | test     		| supersecure	| Hulu.com		| 9.95				|
		| Disney+				| anothertest   | RidleyScott	| google.com	| 8.99				|
		| Netflix			    | test     		| supersecure	| netflix.com	| 9.95				|
		And the following subscriptions have temporary access links:
		| subscription_name	| end_date      |
		| Hulu          	| 2022-01-01    |
		| Netflix          	| 2025-01-01    |

    Scenario: User can create a temporary access link
	    Given I am on the homepage
		When I view the "Disney+" subscription
  		And I click the "Generate Shareable Link" button
        Then I should see a temporary share link
		  
    Scenario: Non-user can view a temporary share link
	    Given I am on the homepage
        When I sign out
		And I view the temporary "Netflix" subscription
  		Then I should see the subscription's temp access page
		  
    Scenario: Temporary share links expire
	    Given I am on the homepage
        When I sign out
		And I view the temporary "Hulu" subscription
  		Then I should see the resource not found page
