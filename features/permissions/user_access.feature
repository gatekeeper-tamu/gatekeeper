Feature: Permissions for Groups and Subscriptions
	As an existing user
    I want to be able to view and edit subscriptions and groups
    based on user-defined rules for access

	Background: users have subscriptions and groups
		Given the test users exist
		And I am logged in
		And the following subscriptions exist for user with email "manny@testerman.com":
		| subscription_name     | username		| password		| url			| cost_per_month	|
		And the following subscriptions exist for user with email "sarah@testerwoman.com":
		| subscription_name     | username		| password		| url			| cost_per_month	|
		| Hulu				    | test     		| supersecure	| Hulu.com		| 9.95				|
		| Disney+				| anothertest   | RidleyScott	| google.com	| 8.99				|
		| Netflix			    | test     		| supersecure	| netflix.com	| 9.95				|
		| Google				| anothertest   | RidleyScott	| google.com	| 8.99				|
		| ESPN					| anothertest   | RidleyScott	| ESPN.com		| 8.99				|
		| Amazon				| anothertest   | RidleyScott	| amazon.com	| 8.99				|
		And the following groups exist for user with email "sarah@testerwoman.com":
		| group_name			|
		| ViewerTest			| 
		| CollaboratorTest	| 
		| AdminTest			| 
		And the following subscriptions exist for the "ViewerTest" group:
		| subscription_name	| permission	|
		| Hulu          	| viewer		|
		| Disney+          	| editor		|
		And the following subscriptions exist for the "CollaboratorTest" group:
		| subscription_name	| permission	|
		| Netflix          	| viewer		|
		| Google          	| viewer		|
		| ESPN          	| editor		|
		And the following subscriptions exist for the "AdminTest" group:
		| subscription_name	| permission	|
		| Amazon          	| viewer		|
		| Google       		| editor		|
		| ESPN				| viewer		|
		And the user with email "manny@testerman.com" belongs to the following groups:
		| permission	| group_name		|
		| viewer		| ViewerTest		|
		| collaborator	| CollaboratorTest	|
		| admin			| AdminTest		|

    Scenario: Viewer user can view group's viewable subscriptions
	    Given I am on the homepage
		When I view the "Hulu" subscription
  		Then I should see the subscription's show page
		  
    Scenario: Collaborator user can view group's viewable subscriptions
	    Given I am on the homepage
		When I view the "Google" subscription
  		Then I should see the subscription's show page
		  
    Scenario: Admin user can view group's viewable subscriptions
	    Given I am on the homepage
		When I view the "Amazon" subscription
  		Then I should see the subscription's show page
		  
    Scenario: Viewer user can view group
	    Given I am on my profile page
		When I click the "Groups" button
		And I View the "ViewerTest" group
  		Then I should see the "ViewerTest" group's show page
		  
    Scenario: Collaborator user can view group
	    Given I am on my profile page
		When I click the "Groups" button
		And I View the "CollaboratorTest" group
  		Then I should see the "CollaboratorTest" group's show page
		  
    Scenario: Admin user can view group
	    Given I am on my profile page
		When I click the "Groups" button
		And I View the "AdminTest" group
  		Then I should see the "AdminTest" group's show page
		  
    Scenario: Viewer user cannot edit group
	    Given I am on my profile page
		When I click the "Groups" button
		And I should not be able to Edit the "ViewerTest" group
		  
    Scenario: Collaborator user can edit group
	    Given I am on my profile page
		When I click the "Groups" button
		And I Edit the "CollaboratorTest" group
  		Then I should see "Add Subscription"
		  
    Scenario: Admin user can edit group
	    Given I am on my profile page
		When I click the "Groups" button
		And I Edit the "AdminTest" group
  		Then I should see the "AdminTest" group's edit page

    Scenario: Viewer user cannot edit group's viewable subscriptions
	    Given I am on the homepage
		When I view the "Hulu" subscription
  		Then I should not see "Edit"
		  
    Scenario: Collaborator user cannot edit group's viewable subscriptions
	    Given I am on the homepage
		When I view the "Netflix" subscription
  		Then I should not see "Edit"
		  
    Scenario: Admin user cannot edit group's viewable subscriptions
	    Given I am on the homepage
		When I view the "ESPN" subscription
  		Then I should not see "Edit"

    Scenario: Viewer user cannot edit group's editable subscriptions
	    Given I am on the homepage
		When I view the "Disney+" subscription
  		Then I should not see "Edit"
		  
    Scenario: Collaborator user cannot edit group's editable subscriptions
	    Given I am on the homepage
		When I view the "ESPN" subscription
  		Then I should not see "Edit"
		  
    Scenario: Admin user can edit group's editable subscriptions
	    Given I am on the homepage
		When I view the "Google" subscription
  		Then I should not see "Edit"
