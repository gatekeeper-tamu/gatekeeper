Feature: Create Subscription
	As an existing user
    I want to be able to create subscriptions
    So that I can store usernames and passwords in Gatekeeper
	Background: users have subscriptions
		Given I exist as a user
		And I am logged in

    Scenario: User can see the new subscription form
		Given I am on the subscriptions "index" page
		When I click the "New Subscription" link
  		Then I should see the new subscription page

    Scenario: User creates a subscription successfully
		Given I am on the subscriptions "new" page
		When I create a new subscription
		And I click the "Create Subscription" button
  		Then I should see the subscription's show page
