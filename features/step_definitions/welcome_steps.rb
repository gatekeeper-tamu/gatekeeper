Given(/^I am on the homepage$/) do
	visit "/"
end
  
Then(/^I should see "(.*?)"$/) do |text|
	page.has_content?(text)
end