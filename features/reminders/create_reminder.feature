Feature: Create Subscription
	As an existing user
    I want to be able to create reminders
    So that I can receive emails reminders for my subscriptions
	Background: users have subscriptions
		Given I exist as a user
		And I am logged in

    Scenario: User can see the new reminder form
		Given I am on the reminders "index" page
		When I click the "New Reminder" link
  		Then I should see the new reminder page

    Scenario: User creates a reminder successfully
		Given I am on the reminders "new" page
		When I create a new reminder
		And I click the "Create Reminder" button
  		Then I should see the reminder's show page
