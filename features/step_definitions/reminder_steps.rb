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
	if (!subscription.nil?)
		create_reminders(subscription, reminder_table)
	end
end


##### WHEN #####
When /^I create a new reminder for "(.*)" subscription$/ do |subscription|
	select("Billing", :from => "reminder_reminder_type")
	select("No", :from => "reminder_recurring")
	fill_in "reminder_end_date", :with => "26-04-2022"
	select("3 days before", :from => "reminder_notification_time")
end

When /^I create a new recurring reminder for "(.*)" subscription$/ do |subscription|
	select("Billing", :from => "reminder_reminder_type")
	select("Yes", :from => "reminder_recurring")
	select("Monthly", :from => "reminder_frequency")
	fill_in "reminder_end_date", :with => "26-04-2022"
	select("3 days before", :from => "reminder_notification_time")
end

When /^I select "(.*)" for reminder recurring$/ do |option|
	select(option, :from => "reminder_recurring")
end

When /^I create a new reminder for "(.*)" subscription with an invalid date$/ do |subscription|
	select("Yes", :from => "reminder_recurring")
	select("Billing", :from => "reminder_reminder_type")
	select("3 days before", :from => "reminder_notification_time")
	fill_in "reminder_end_date", :with => "29-02-2022"
end

When /^I delete a reminder for "(.*)"$/ do |subscription_name|
	if (@subscription.nil?)
		@subscription = Subscription.where(subscription_name: subscription_name).first
	end
	path = @subscription.id
	if (@reminder.nil?)
		@reminder = Reminder.where(:subscription_id => path).first
	end
	first(:link, 'X', minimum: 1).click
end

##### THEN #####
Then /^I should see the reminder "(.*)" page$/ do |page_name|
	if (page_name == "show")
		sub_id = URI.parse(current_url).path.split('/').last
		reminder = Reminder.where(:id => sub_id).first
		expect(!reminder.nil?)
		page.should have_content("Reminder was successfully created.")
	elsif (page_name == "new")
		page.should have_content("New")
	elsif (page == "index")
		path = "/reminders"
		visit path
		current_path.should eq("/reminders")
	end
end

Then /^I should see reminders for the "(.*)" subscription$/ do |subscription|
	if (@subscription.nil?)
		@subscription = Subscription.where(:subscription_name => subscription).first
	end
	for reminder in @subscription.reminders
		page.should have_content("Occurs:")
		page.should have_content("Recurs:")
	end
end

Then /^the reminder should not exist$/ do
	page.should have_content("Reminder was successfully destroyed.")
end

Then /^I should see an error$/ do
	page.should have_content("End date can't be blank")
end

Then /^I should see the frequency options$/ do
	page { should have_selector('reminder_frequency', text: 'Weekly') }
end

Then /^I should not see the frequency options$/ do
	page.should have_no_content('frequency')
end

Then /^I should not see reminders for the "(.*)" subscription$/ do |subscription_name|
	page.should have_no_content(subscription_name)
end