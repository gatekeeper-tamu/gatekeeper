Feature: View Personal Statistics
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

  Scenario: Signed in user sees personal statistics graph
    Given I am on the personal statistics page
    Then I should see the pie chart detailing subscription costs

  Scenario: Signed in user sees personal statistics table
    Given I am on the personal statistics page
    Then I should see the table showing subscription details

  Scenario: Signed in user sees personal statistics total monthly cost
    Given I am on the personal statistics page
    Then I should see my total monthly cost

  Scenario: Signed in user sees personal statistics total overall cost
    Given I am on the personal statistics page
    Then I should see my total overall cost
