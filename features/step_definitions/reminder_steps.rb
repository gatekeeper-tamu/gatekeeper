def create_reminders(subscription, reminder_table)
    reminder_table.hashes.each do |reminder|
        subscription.reminders.create reminder
    end
end

##### GIVEN #####
Given /I am on the reminders "(.*)" page for "(.*)" subscription/ do |page, subscription|
	path = ""
	if (page == "index")
		path = "reminders##{page}"
	elsif (page == "new")
		if (@subscription.nil?)
			@subscription = Subscription.where(:subscription_name => subscription).first
		end
		path = "reminders/new?subscription_id=" + @subscription.id
	else
		path = "reminders/#{page}"
	end
	visit path
	if (page == "index")
		current_path.should eq("/reminders")
	end
end

Given('the following reminders exist for {string} subscription:') do |string, reminder_table|
	subscription ||= Subscription.where(:subscription_name => string).first
<<<<<<< HEAD
	if (!subscription.nil?)
=======
	if (!subscription.nil?) 
>>>>>>> 404c397 ([Reminder Feature] implemented scheduling logic and basic UI for displaying active reminders)
		create_reminders(subscription, reminder_table)
	end
end




##### WHEN #####
When /^I create a new reminder for "(.*)" subscription$/ do |subscription|
	select("Yes", :from => "reminder_recurring")
	select("Billing", :from => "reminder_reminder_type")
	select("3 days before", :from => "reminder_time_delta")
	fill_in "reminder_end_date", :with => "26-04-2022"
end

##### THEN #####
Then /^I should see the reminder's show page$/ do
	sub_id = URI.parse(current_url).path.split('/').last
	reminder = Reminder.where(:id => sub_id).first
	expect(!reminder.nil?)
	page.should have_content("Reminder was successfully created.")
end


Then /^I should see the new reminder page$/ do
	page.should have_content("New")
end

Then /^I should see reminders for the "(.*)" subscription$/ do |subscription|
	if (@subscription.nil?)
		@subscription = Subscription.where(:subscription_name => subscription).first
	end
	for reminder in @subscription.reminders
		page.should have_content("Reminder type:")
	end
end

Then /^the reminder should not exist$/ do
	page.should have_content("Reminder was successfully destroyed.")
end
