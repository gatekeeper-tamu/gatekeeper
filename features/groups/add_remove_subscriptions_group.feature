Feature: Add and Remove Subscriptions from Group Feature
	As an existing user
    I want to be able to add and remove subscriptions from my groups
    So that I can share usernames and passwords on Gatekeeper

	Background: users have groups
		Given the test users exist
		And I am logged in
		And the following groups exist for user with email "manny@testerman.com":
		| group_name	|
		| Test Family	| 
		And the following subscriptions exist for user with email "manny@testerman.com":
		| subscription_name     | username		| password		| url			| cost_per_month	|
		| Netflix			    | test     		| supersecure	| netflix.com	| 9.95				|
		| Google				| anothertest   | RidleyScott	| google.com	| 8.99				|
		And the following subscriptions exist for user with email "sarah@testerwoman.com":
		| subscription_name     | username		| password		| url			| cost_per_month	|
		| Hulu				    | test     		| supersecure	| Hulu.com		| 9.95				|

    Scenario: User can create a group with a subscription
		Given I am on the groups "new" page
		When I put "Roomies" in the "group_group_name" field
  		And I add "Netflix" to the group subscriptions
		And I click the "Create Group" button
  		Then I should see the "Roomies" group's show page
  		And I should see "Netflix"

    Scenario: User can add a subscription to a group
		Given I am on the groups "index" page
		When I Edit the "Test Family" group
  		And I add "Netflix" to the group subscriptions
		And I click the "Update Group" button
  		Then I should see the "Test Family" group's show page
  		And I should see "Netflix"

    Scenario: User can remove a subscription from a group
        Given the Roomies group exists
		And I am on the groups "index" page
  		When I Edit the "Roomies" group
  		And I remove "Netflix" from the group subscriptions
		And I click the "Update Group" button
  		Then I should see the "Roomies" group's show page
  		# And I should not see "Netflix"
