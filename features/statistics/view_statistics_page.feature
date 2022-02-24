Feature: View the statistics page
  As an existing user
  I want to be able to view the statistics page
  So that I can see analytics on myself and other users

Background: users have statistics
	Given the test users exist
	And I am logged in

Scenario: Signed in user can view statistics page
  Given I am on my profile page
  When I click the Statistics link
  Then I should see the sitewide statistics page

Scenario: User navigates to sitewide statistics page
  Given I am on the statistics page
  When I click the Sitewide link
  Then I should see the sitewide statistics page

Scenario: User navigates to group statistics page
  Given I am on the statistics page
  When I click the Group link
  Then I should see the group statistics page

Scenario: User navigates to personal statistics page
  Given I am on the statistics page
  When I click the Personal link
  Then I should see the personal statistics page
