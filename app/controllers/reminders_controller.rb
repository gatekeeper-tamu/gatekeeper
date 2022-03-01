class RemindersController < ApplicationController
  before_action :set_reminder, only: %i[ show edit update destroy ]

  # GET /reminders or /reminders.json
  def index
    @reminders = Reminder.all
  end

  # GET /reminders/1 or /reminders/1.json
  def show
  end

  # GET /reminders/new
  def new
    @reminder = Reminder.new(:subscription_id => params[:subscription_id])
  end

  # GET /reminders/1/edit
  def edit
  end

  # POST /reminders or /reminders.json
  def create
    @reminder = Reminder.new(reminder_params)
    @reminder.subscription = Subscription.find(params[:subscription_id])

    respond_to do |format|
      if @reminder.save
        ReminderMailer.with(reminder: @reminder).new_reminder_email.deliver_now

        ##TODO: use the ActiveJobs when implementing recurrence
        #SendReminderEmailJob.set(wait: 1.minute).perform_later

        format.html { redirect_to reminder_url(@reminder), notice: "Reminder was successfully created." }
        format.json { render :show, status: :created,   location: @reminder }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reminders/1 or /reminders/1.json
  def update
    respond_to do |format|
      if @reminder.update(reminder_params)
        format.html { redirect_to reminder_url(@reminder), notice: "Reminder was successfully updated." }
        format.json { render :show, status: :ok, location: @reminder }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reminder.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reminders/1 or /reminders/1.json
  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy

    respond_to do |format|
      format.html { redirect_to reminders_url, notice: "Reminder was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reminder
      begin
        @reminder = Reminder.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        puts "Can't access this page!"
        redirect_to "/404.html"
      rescue => exception
        puts "ERROR! -> #{exception}"
      end
    end

    # Only allow a list of trusted parameters through.
    def reminder_params
      params.require(:reminder).permit(:recurring, :reminder_type, :time_delta, :end_date, :subscription_id)
    end
end
