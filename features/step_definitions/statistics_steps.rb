# include user_steps

##### GIVEN #####
Given /I am on the statistics page/ do
	path = "/statistics"
	visit path
end

##### WHEN #####
When /I click the Statistics link/ do
	click_link "Statistics"
	path = "/statistics"
	visit path
end

When /I click the Sitewide link/ do
	click_link "Sitewide"
	path = "/statistics#sitewide"
	visit path
end

When /I click the Group link/ do
	click_link "Group"
	path = "/statistics#group"
	visit path
end

When /I click the Personal link/ do
	click_link "Personal"
	path = "/statistics#personal"
	visit path
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