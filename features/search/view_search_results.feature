Feature: View search results
    I want to access show page
    and see search results

Scenario: Access the search results on show page
    Given I am on the search page
    When I fill in the search form and
    And I click the "search" button
    Then I should see search's show page 