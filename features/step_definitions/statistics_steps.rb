# include user_steps

##### GIVEN #####
Given /I am on the statistics page/ do
	path = "/statistics"
	visit path
end

##### WHEN #####
When /I click the "(Sitewide|Group|Personal)" tab/ do |action|
	tab = page.find("a##{action.downcase}-tab.nav-link")
	tab.click
end

##### THEN #####
Then /^I should see the sitewide statistics page$/ do
	page.should have_content("Sitewide statistics")
end

Then /^I should see the group statistics page$/ do
	page.should have_content("Group statistics")
end

Then /^I should see the personal statistics page$/ do
	page.should have_content("Personal statistics")
end