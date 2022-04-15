Feature: View Group
	As an existing user
    I want to be able to view groups
    So that I can see usernames and passwords on Gatekeeper

	Background: users have groups
		Given the test users exist
		And I am logged in
		And the following groups exist for user with email "manny@testerman.com":
		| group_name	|
		| TestFamily	| 
		And the following groups exist for user with email "sarah@testerwoman.com":
		| group_name	|
		| Roommates		| 
    Scenario: Signed in user can view group homepage
	    Given I am on my profile page
		When I click the "Groups" button
  		Then I should see my groups

    Scenario: User views a group successfully
	    Given I am on my profile page
		When I click the "Groups" button
		And I View the "TestFamily" group
  		Then I should see the "TestFamily" group's show page
	
    Scenario: User tries to view another user's group
	    Given I am on the homepage
		When I access the "Roommates" group
  		Then I should see the resource not found page
	
    Scenario: Unauthenticated user tries to view a group
		Given I am not logged in
		When I access the "TestFamily" group
  		Then I am on the sign in page
