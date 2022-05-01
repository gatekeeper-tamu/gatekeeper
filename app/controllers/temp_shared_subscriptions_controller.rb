class TempSharedSubscriptionsController < ApplicationController
  #before page loads, authenticate user is logged in
  before_action :authenticate_user!, except: %i[ show ]
  before_action :set_temp_shared_subscription, only: %i[ show edit update destroy share send_temp_access_email ]

  # GET /temp_shared_subscriptions or /temp_shared_subscriptions.json
  def index
    #show only SharedSubscription where the current user is the owner of the subscription
    @temp_shared_subscriptions = TempSharedSubscription.where(subscription: Subscription.where(user: current_user))
  end

  # GET /temp_shared_subscriptions/1 or /temp_shared_subscriptions/1.json
  def show
  end

  # GET /temp_shared_subscriptions/new
  def new
    @temp_shared_subscription = TempSharedSubscription.new
  end

  # GET /temp_shared_subscriptions/1/edit
  def edit
  end

  # POST /temp_shared_subscriptions or /temp_shared_subscriptions.json
  def create
    @temp_shared_subscription = TempSharedSubscription.new(temp_shared_subscription_params)

    respond_to do |format|
      if @temp_shared_subscription.save
        format.html { redirect_to "/subscriptions/#{@subscription.id}", notice: "Temp sharing link was successfully created." }
        format.json { render :show, status: :created, location: @temp_shared_subscription }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @temp_shared_subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /temp_shared_subscriptions/1 or /temp_shared_subscriptions/1.json
  def update
    respond_to do |format|
      if @temp_shared_subscription.update(temp_shared_subscription_params)
        format.html { redirect_to "/subscriptions/#{@subscription.id}", notice: "Temp sharing link was successfully updated." }
        format.json { render :show, status: :ok, location: @temp_shared_subscription }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @temp_shared_subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /temp_shared_subscriptions/1 or /temp_shared_subscriptions/1.json
  def destroy
    @temp_shared_subscription.destroy

    respond_to do |format|
      format.html { redirect_to "/subscriptions/#{@subscription.id}", notice: "Temp sharing link was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def share
  end

  def send_temp_access_email
    TempAccessMailer.share_subscription_email(@temp_shared_subscription, @subscription, params["no_model_fields"]["email"], current_user).deliver
    respond_to do |format|
      format.html { redirect_to "/subscriptions/#{@subscription.id}", notice: "Temp sharing link was successfully shared." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_temp_shared_subscription
      @temp_shared_subscription = TempSharedSubscription.find(params[:id])
      if (@temp_shared_subscription.end_date < Date.today)
        @temp_shared_subscription.destroy
        puts "Can't access this page! Temp Share Link expired"
        redirect_to "/404.html"
      end
      @subscription = @temp_shared_subscription.subscription
    rescue ActiveRecord::RecordNotFound
      puts "Can't access this page! Invalid login. SET_TEMP_SUBSCRIPTION"
      redirect_to "/404.html"
    end

    # Only allow a list of trusted parameters through.
    def temp_shared_subscription_params
      params.require(:temp_shared_subscription).permit(:end_date, :subscription)
    end
end
