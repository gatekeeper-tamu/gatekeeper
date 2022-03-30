# include user_steps

Given /I am on the search page/ do
 	path = "/search"
 	visit path
 end

####WHEN####
When /I submit the search form / do 
	fill_in 'search[title]', :with => 'Riverdale'
end

When /^I click the search button$/ do
    click_button "search"
end

####THEN####
Then /^I should see search's show page$/ do
	page.should have_content("Search Results")
end