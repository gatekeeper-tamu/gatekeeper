def create_reminders(subscription, reminder_table)
    reminder_table.hashes.each do |reminder|
        subscription.reminders.create reminder
    end
end

##### GIVEN #####
Given /I am on the reminders "(.*)" page/ do |page|
	path = ""
	if (page == "index") 
		path = "reminders##{page}"
	else
		path = "reminders/#{page}"
	end
	visit path
	if (page == "index") 
		current_path.should eq("/reminders")
	end
end

##### WHEN #####
When /^I create a new reminder$/ do
	fill_in "reminder_recurring", :with => "True"
	fill_in "reminder_reminder_type", :with => "cancellation"
	fill_in "reminder_time_delta", :with => "2 weeks"
	fill_in "reminder_end_date", :with => 2022-02-02
end

##### THEN #####
Then /^I should see the reminder's show page$/ do
	sub_id = URI.parse(current_url).path.split('/').last
	reminder = Reminder.where(:id => sub_id).first
	expect(!reminder.nil?)
	page.should have_content(reminder.end_date)
end

Then /^I should see the new reminder page$/ do
	page.should have_content("New Reminder")
end