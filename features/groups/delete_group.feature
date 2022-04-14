Feature: Delete Group
	As an existing user
    I want to be able to delete groups
    So that I can remove usernames and passwords from Gatekeeper

	Background: users have groups
		Given I am logged in
		And the following groups exist for user with email "manny@testerman.com":
		| group_name	|
		| TestFamily	|
		
    Scenario: User deletes a group successfully
	    Given I am on my profile page
			When I click the "Groups" button
			And I Delete the "TestFamily" group
  		Then the "TestFamily" group should not exist
	
    Scenario: User tries to view a deleted group
	    Given I am on my profile page
			When I click the "Groups" button
			And I Delete the "TestFamily" group
			And I access the "TestFamily" group
  		Then I should see the resource not found page
