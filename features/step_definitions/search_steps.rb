# include user_steps

Given /I am on the search page/ do
 	path = "/search"
 	visit path
 end

####WHEN####
When /^I click the search link$/ do
	click_link('Search ')
end
When /I fill in the search form / do
	fill_in 'search_title', :with => 'Riverdale'
end

When /^I click the search button$/ do
    find('.btn', :text => '"Search"').click
end

####THEN####

Then /^I should see the search page$/ do
	page.should have_content("Search for a show or movie below to find streaming platforms!")
end
Then /^I should see search's show page$/ do
	page.should have_content("Join our platform today")
end