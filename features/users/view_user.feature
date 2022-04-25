Feature: View user profiles
    As a user
    I want to be able to view existing user profiles

    Scenario: User does exist
        Given the user exists
        When I visit the user profile path
        Then I should see the user profile page

    Scenario: User does not exist and redirects
        Given the user does not exist
        When I visit the user profile path
        Then I should see the error 404 page