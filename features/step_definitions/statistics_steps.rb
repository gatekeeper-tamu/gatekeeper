# include user_steps
# include subscription_steps
# include group_steps

##### GIVEN #####
Given /I am on the statistics page/ do
	path = "/statistics"
	visit path
end

Given /I am on the (sitewide|group|personal) statistics page/ do |action|
	path = "/statistics"
	visit path
	tab = page.find("a##{action.downcase}-tab.nav-link")
	tab.click
end

##### WHEN #####
When /I click the "(Sitewide|Group|Personal)" tab/ do |action|
	tab = page.find("a##{action.downcase}-tab.nav-link")
	tab.click
end

##### THEN #####
Then /^I should see the sitewide statistics page$/ do
	page.should have_content("Sitewide Statistics")
end

Then /^I should see the group statistics page$/ do
	page.should have_content("Group Statistics")
end

Then /^I should see the personal statistics page$/ do
	page.should have_content("Personal Statistics")
end

Then /^I should see the chart (.*)$/ do |chart|
	page.should have_content("Loading...")
end

### personal ###
Then /^I should see the table showing subscription details$/ do
	page.should have_content("http://netflix.com")
end

Then /^I should see my total monthly cost$/ do
	page.should have_content("Your total monthly cost of serivces on our website is $18.94")
end

Then /^I should see my total overall cost$/ do
	page.should have_content("Your total all-time cost of serivces tracked on our website is $18.94")
end

### group ###
Then /^I should see my group's total monthly cost$/ do
	page.should have_content("The total monthly cost for this group is $14.95")
end

### sitewide ###
Then /^I should see the total subscription count$/ do
	page.should have_content("accounts stored on gatekeeper.com")
end