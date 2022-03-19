# include user_steps

def create_groups(user, group_table) 
	group_table.hashes.each do |group|
		user.owned_groups.create group
	end
end

##### GIVEN #####
Given /the following groups exist for user with email "(.*)"/ do |user_email, group_table|
	user ||= User.where(:email => user_email).first
	if (!user.nil?) 
		create_groups(user, group_table)
	end
end
Given /the following subscriptions and users exist for the "(.*)" group/ do |group_name, group_table|
	group ||= Group.where(:group_name => group_name).first
	if (!group.nil?) 
		group_table.hashes.each do | hash_val |
			subscription ||= Subscription.where(:subscription_name => hash_val["subscription_name"])
			if (!subscription.nil?)
				group.subscriptions << subscription
			end
			user ||= User.where(:email => hash_val["user_email"])
			if (!user.nil?)
				group.users << user
			end
		end
	end
end


Given /I am on the groups "(.*)" page/ do |page|
	path = ""
	if (page == "index") 
		path = "groups##{page}"
	else
		path = "groups/#{page}"
	end
	visit path
	if (page == "index") 
		current_path.should eq("/groups")
	end
end

Given /the Roomies group exists/ do
	expect(!@user.nil?)
	sarah ||= find_user("sarah@testerwoman.com")
	roomies = @user.owned_groups.create(group_name: "Roomies", user_ids: sarah.id)
	netflix ||= @user.subscriptions.where(subscription_name: "Netflix").first
	if (!netflix.nil?)
		roomies.subscriptions << netflix
		puts roomies.subscriptions
	end
end

Given /the Flatmates group exists/ do
	expect(!@user.nil?)
	sarah ||= find_user("sarah@testerwoman.com")
	flatmates = sarah.owned_groups.create(group_name: "Flatmates", user_ids: @user.id)
	hulu ||= sarah.subscriptions.where(subscription_name: "Hulu").first
	if (!hulu.nil?)
		flatmates.subscriptions << hulu
		puts flatmates.subscriptions
	end
end

Given /the Flatmates2 group exists/ do
	expect(!@user.nil?)
	sarah ||= find_user("sarah@testerwoman.com")
	flatmates = sarah.owned_groups.create(group_name: "Flatmates2", user_ids: @user.id)
	hulu ||= sarah.subscriptions.where(subscription_name: "Hulu").first
	flatmates.members.first.permission = Membership.permissions[:admin]
	if (!hulu.nil?)
		flatmates.subscriptions << hulu
		puts flatmates.subscriptions
	end
end

##### WHEN #####
When /^I access the "(.*)" group$/ do |group_name|
	if (@group_id.nil?)
		if (@group.nil?)
			@group = Group.where(:group_name => group_name).first
		end
		expect(@group.nil? == false)
		@group_id = @group.id
	end
	path = "/groups/" + @group_id
	visit path
end

When /^I (Edit|Destroy|Show) the "(.*)" group$/ do |action, group_name|
	@group = Group.where(:group_name => group_name).first
	@group_id = @group.id
	row = page.find("tr", text: group_name)
	row.click_link action
end

When /^I should not be able to (Edit|Destroy|Show) the "(.*)" group$/ do |action, group_name|
	@group = Group.where(:group_name => group_name).first
	@group_id = @group.id
	row = page.find("tr", text: group_name)
	row.should_not have_content(action)
end

When /^I (add|remove) "(.*)" (to|from) the group (user|subscription)s$/ do |action, value, action2, table|
	opt = all("#group_#{table}_ids").last.find(:option, value)
	if (action == "add")
		opt.select_option
	else
		opt.unselect_option
	end
end

##### THEN #####
Then /^I should see my groups$/ do
	path = "/groups"
	visit path
	for group in @user.groups
		page.should have_content(group.group_name)
		page.should have_content(group.owner.username)
	end
end

Then /^I should see the "(.*)" group$/ do |group_name|
	group = Group.where(:group_name => group_name).first
	page.should have_content(group.group_name)
	page.should have_content(group.owner.username)
end

Then /^the "(.*)" group should not exist$/ do |group_name|
	group = Group.where(:group_name => group_name).first
	expect(group.nil?)
end

Then /^I should see the "(.*)" group's show page$/ do |group_name|
	group_id = URI.parse(current_url).path.split('/').last
	group = Group.where(:id => group_id).first
	expect(!group.nil?)
	expect(group.group_name == group_name)
	page.should have_content(group.group_name)
	page.should have_content(group.owner.username)
end

Then /^I should see the new group page$/ do
	page.should have_content("New Group")
end

Then /^I should see my group subscriptions$/ do
	for group in @user.groups
		for subscription in group.subscriptions
			page.should have_content(subscription.subscription_name)
			page.should have_content(subscription.username)
		end
	end
end