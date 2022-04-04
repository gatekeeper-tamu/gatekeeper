# include user_steps

def create_subscriptions(user, subscription_table) 
	subscription_table.hashes.each do |subscription|
		subscription["user"] = user
		user.subscriptions.create subscription
	end
end

##### GIVEN #####
Given /the following subscriptions exist for user with email "(.*)"/ do |user_email, subscription_table|
	user ||= User.where(:email => user_email).first
	if (!user.nil?) 
		create_subscriptions(user, subscription_table)
	end
end

Given /the following subscriptions have temporary access links/ do |temp_subscription_table|
	temp_subscription_table.hashes.each do |t|
		sub = Subscription.where(subscription_name: t["subscription_name"]).first
		expect(sub.nil?).to be false
		TempSharedSubscription.create(subscription: sub, end_date: t["end_date"])
	end
end

Given /I am on the subscriptions "(.*)" page/ do |page|
	path = ""
	if (page == "index") 
		path = "subscriptions##{page}"
	else
		path = "subscriptions/#{page}"
	end
	visit path
	if (page == "index") 
		current_path.should eq("/subscriptions")
	end
end

##### WHEN #####
When /^I view the "(.*)" subscription$/ do |sub_name|
	if (@subscription.nil?)
		@subscription = Subscription.where(subscription_name: sub_name).first
	end
	path = "/subscriptions/" + @subscription.id
	visit path
end

When /^I view the temporary "(.*)" subscription$/ do |sub_name|
	if (@subscription.nil?)
		@subscription = Subscription.where(subscription_name: sub_name).first
	end
	temp_sub = TempSharedSubscription.where(subscription: @subscription).first
	expect(temp_sub.nil?).to be false
	path = "/shares/" + temp_sub.id
	visit path
end

When /^I delete the "(.*)" subscription$/ do |sub_name|
	@subscription = Subscription.where(subscription_name: sub_name).first
	click_button "Delete"
end

When /^I create a new subscription$/ do
	fill_in "subscription_subscription_name", :with => "Netflix"
	fill_in "subscription_username", :with => "TestUsername"
	fill_in "subscription_password", :with => "supersecurelongpassword"
	fill_in "subscription_url", :with => "http://netflix.com"
	fill_in "subscription_cost_per_month", :with => 12.99
	fill_in "subscription_image", :with => "myimage.url/test.png"
end


##### THEN #####
Then /^I should see my subscriptions$/ do
	path = "/subscriptions"
	visit path
	for subscription in @user.subscriptions
		page.should have_content(subscription.subscription_name)
		page.should have_content(subscription.username)
	end
end

Then /^I should see the "(.*)" subscription$/ do |sub_name|
	subscription = Subscription.where(subscription_name: sub_name).first
	page.should have_content(subscription.subscription_name)
	page.should have_content(subscription.username)
end

Then /^I should see a temporary share link$/ do
	page.should have_content("/shares/")
	page.should have_content("Temporary Share Links")
end

Then /^the "(.*)" subscription should not exist$/ do |sub_name|
	subscription = Subscription.where(:subscription_name => sub_name).first
	expect(subscription).to be nil
end

Then /^I should see the subscription's show page$/ do
	sub_id = URI.parse(current_url).path.split('/').last
	subscription = Subscription.where(id: sub_id).first
	expect(subscription.present?).to be true
	page.should have_content(subscription.subscription_name)
	page.should have_content(subscription.username)
end

Then /^I should see the subscription's temp access page$/ do
	sub_id = URI.parse(current_url).path.split('/').last
	temp = TempSharedSubscription.where(id: sub_id).first
	expect(temp.present?).to be true
	subscription = temp.subscription
	page.should have_content(subscription.subscription_name)
	page.should have_content(subscription.username)
end

Then /^I should see the new subscription page$/ do
	page.should have_content("New Subscription")
end