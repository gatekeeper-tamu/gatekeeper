Feature: Add and Remove Users from Group Feature
	As an existing user
    I want to be able to add and remove users from my groups
    So that I can share usernames and passwords on Gatekeeper

	Background: users have groups
		Given the test users exist
		And I am logged in
		And the following groups exist for user with email "manny@testerman.com":
		| group_name	|
		| Test Family	| 

    Scenario: User can create a group with a user
		Given I am on the groups "new" page
		When I put "Roomies" in the "group_group_name" field
  		And I add "saraht" to the group
		And I click the "Create Group" button
  		Then I should see the "Roomies" group's show page
  		And I should see "saraht"

    Scenario: User can add a user to a group
		Given I am on the groups "index" page
		When I Edit the "Test Family" group
  		And I add "saraht" to the group
		And I click the "Update Group" button
  		Then I should see the "Test Family" group's show page
  		And I should see "saraht"

    Scenario: User can remove a user from a group
        Given the Roomies group exists
		And I am on the groups "index" page
  		When I Edit the "Roomies" group
  		And I remove "saraht" from the group
		And I click the "Update Group" button
  		Then I should see the "Roomies" group's show page
  		And I should not see "saraht"
