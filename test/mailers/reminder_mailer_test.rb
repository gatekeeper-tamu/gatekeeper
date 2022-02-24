require "test_helper"

class ReminderMailerTest < ActionMailer::TestCase
  test "new reminder email" do
    # Set up an reminder based on the fixture
    reminder = reminders(:one)

    # Set up an email using the reminder contents
    email = ReminderMailer.with(reminder: reminder).new_reminder_email

    # Check if the email is sent
    assert_emails 1 do
      email.deliver_now
    end

    # Check the contents are correct
    assert_equal ["gatekeeper.tamu@gmail.com"], email.from
    assert_equal ["gatekeeper.tamu@gmail.com"], email.to
    assert_equal "You got a new reminder!", email.subject
    assert_match reminder.subscription_id, email.html_part.body.encoded
    assert_match reminder.subscription_id, email.text_part.body.encoded
    assert_match reminder.reminder_id, email.html_part.body.encoded
    assert_match reminder.reminder_id, email.text_part.body.encoded
    assert_match reminder.time_delta, email.html_part.body.encoded
    assert_match reminder.time_delta, email.text_part.body.encoded
    assert_match reminder.recurring, email.html_part.body.encoded
    assert_match reminder.recurring, email.text_part.body.encoded
    assert_match reminder.message, email.html_part.body.encoded
    assert_match reminder.message, email.text_part.body.encoded
  end
end
