Feature: View Sitewide Statistics
  As an existing user
  I want to be able to view the sitewide statistics page
  So that I can see analytics on all Gatekeeper users

Background: users have statistics and subscriptions
	Given the test users exist
	And I am logged in
  And the following subscriptions exist for user with email "manny@testerman.com":
  | subscription_name     | username		| password		| url			| cost_per_month	|
  | Netflix			    | test     		| supersecure	| netflix.com	| 9.95				|
  | Google				| anothertest   | RidleyScott	| google.com	| 8.99				|
  And the following subscriptions exist for user with email "sarah@testerwoman.com":
  | subscription_name     | username		| password		| url			| cost_per_month	|
  | Hulu				    | test     		| supersecure	| Hulu.com		| 9.95				|

  Scenario: Signed in user sees sitewide statistics chart
    Given I am on the sitewide statistics page
    Then I should see the pie chart detailing subscription counts

  Scenario: Signed in user sees sitewide statistics graph
    Given I am on the sitewide statistics page
    Then I should see the bar graph showing subscription costs

  Scenario: Signed in user sees sitewide statistics total subscription count
    Given I am on the sitewide statistics page
    Then I should see the total subscription count
