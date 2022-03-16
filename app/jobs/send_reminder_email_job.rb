class SendReminderEmailJob < ApplicationJob
  self.queue_adapter = :sidekiq
# #ActiveJob retry scheme: 5 retries, 3 seconds apart
  # sidekiq_options retry: 5
  queue_as :default
  

  def perform(*args)
    # Do something later
    ReminderMailer.with(reminder: @args).new_reminder_email.deliver_now
    puts "SendReminderEmailJob is performed"
    
  end

end
