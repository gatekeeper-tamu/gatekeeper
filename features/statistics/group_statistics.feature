Feature: View Group Statistics
  As an existing user
  I want to be able to view my personal statistics page
  So that I can see analytics on myself

Background: users have statistics and subscriptions
	Given the test users exist
	And I am logged in
  And the following subscriptions exist for user with email "manny@testerman.com":
  | subscription_name     | username		| password		| url			| cost_per_month	|
  | Netflix			    | test     		| supersecure	| netflix.com	| 9.95				|
  | Google				| anothertest   | RidleyScott	| google.com	| 8.99				|
  And the following subscriptions exist for user with email "sarah@testerwoman.com":
  | subscription_name     | username		| password		| url			| cost_per_month	|
  | Hulu				    | test     		| supersecure	| Hulu.com		| 5.00				|
  And the following groups exist for user with email "manny@testerman.com":
		| group_name	|
		| Test Family	| 
	And the following subscriptions exist for the "Test Family" group:
		| subscription_name	| permission |
		| Netflix          	| viewer	 |
		| Hulu          	| viewer	 |
	And the user with email "sarah@testerwoman.com" belongs to the following groups:
		| group_name	| permission |
		| Test Family  	| viewer	 |

  Scenario: Signed in user sees group statistics chart
    Given I am on the group statistics page
    Then I should see the pie chart detailing group subscription costs

  Scenario: Signed in user sees group statistics member chart
    Given I am on the group statistics page
    Then I should see the pie chart detailing cost per member

  Scenario: Signed in user sees group statistics total monthly cost
    Given I am on the group statistics page
    Then I should see my group's total monthly cost
