Feature: Create Subscription
	As an existing user
    I want to be able to create groups
    So that I can share usernames and passwords in Gatekeeper
	Background: users exist
		Given I exist as a user
		And I am logged in

    Scenario: User can see the new group form
		Given I am on the groups "index" page
		When I click the "New Group" link
  		Then I should see the new group page

    Scenario: User creates a group successfully
		Given I am on the groups "new" page
		When I create a new group
		And I click the "Create Group" button
  		Then I should see the "Roomies" group's show page
