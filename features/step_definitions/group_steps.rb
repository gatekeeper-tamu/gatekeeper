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

##### WHEN #####
When /^I view the "(.*)" group$/ do |group_name|
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

When /^I delete the "(.*)" group$/ do |group_name|
	@group = Group.where(:group_name => group_name).first
	@group_id = @group.id
	puts "Group_ID=#{@group_id}"
	click_link "Destroy"
end

When /^I create a new group$/ do
	fill_in "group_group_name", :with => "Roomies"
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