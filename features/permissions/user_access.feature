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
		| Viewer Test			| 
		| Collaborator Test	| 
		| Admin Test			| 
		And the following subscriptions exist for the "Viewer Test" group:
		| subscription_name	| permission	|
		| Hulu          	| viewer		|
		| Disney+          	| editor		|
		And the following subscriptions exist for the "Collaborator Test" group:
		| subscription_name	| permission	|
		| Netflix          	| viewer		|
		| Google          	| viewer		|
		| ESPN          	| editor		|
		And the following subscriptions exist for the "Admin Test" group:
		| subscription_name	| permission	|
		| Amazon          	| viewer		|
		| Google       		| editor		|
		| ESPN				| viewer		|
		And the user with email "manny@testerman.com" belongs to the following groups:
		| permission	| group_name		|
		| viewer		| Viewer Test		|
		| collaborator	| Collaborator Test	|
		| admin			| Admin Test		|

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
		And I Show the "Viewer Test" group
  		Then I should see the "Viewer Test" group's show page
		  
    Scenario: Collaborator user can view group
	    Given I am on my profile page
		When I click the "Groups" button
		And I Show the "Collaborator Test" group
  		Then I should see the "Collaborator Test" group's show page
		  
    Scenario: Admin user can view group
	    Given I am on my profile page
		When I click the "Groups" button
		And I Show the "Admin Test" group
  		Then I should see the "Admin Test" group's show page
		  
    Scenario: Viewer user cannot edit group
	    Given I am on my profile page
		When I click the "Groups" button
		And I should not be able to Edit the "Viewer Test" group
		  
    Scenario: Collaborator user can edit group
	    Given I am on my profile page
		When I click the "Groups" button
		And I Edit the "Collaborator Test" group
  		Then I should see "Add Subscription"
		  
    Scenario: Admin user can edit group
	    Given I am on my profile page
		When I click the "Groups" button
		And I Edit the "Admin Test" group
  		Then I should see the "Admin Test" group's edit page

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
