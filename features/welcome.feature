Feature: Home page
	As a new Cucumber user
  	I want to learn how to write a feature

  	Scenario: Access the log in page
		Given I am on the homepage
		When I click "LOGIN"
		Then I am on the sign in page
	
