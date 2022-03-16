Feature: Search for a Movie or TV show 

As a viewer of the Search page
I want to be able to Search for Movie or TV show
So I can see show results 

Scenario: view a search result successfully
	    Given I am on the "search" page
		When I search for a Movie or TV show
  		Then I should see the search's show page with results