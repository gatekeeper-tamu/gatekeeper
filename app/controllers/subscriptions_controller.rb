class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscription, only: %i[ show edit update destroy ]

  # GET /subscriptions or /subscriptions.json
  def index
    @subscriptions = current_user.subscriptions
    # @groups = current_user.owned_groups.sort_by(&:group_name)
    @groups = (current_user.owned_groups | current_user.groups).sort_by(&:group_name)
  end

  # GET /subscriptions/1 or /subscriptions/1.json
  def show
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
    @subscription.user = current_user
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions or /subscriptions.json
  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.user = current_user

    respond_to do |format|
      if @subscription.save
        format.html { redirect_to subscription_url(@subscription), notice: "Subscription was successfully created." }
        format.json { render :show, status: :created, location: @subscription }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subscriptions/1 or /subscriptions/1.json
  def update
    respond_to do |format|
      if @subscription.update(subscription_params)
        format.html { redirect_to subscription_url(@subscription), notice: "Subscription was successfully updated." }
        format.json { render :show, status: :ok, location: @subscription }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subscriptions/1 or /subscriptions/1.json
  def destroy
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: "Subscription was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      begin
        @subscription = current_user.subscriptions.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        puts "Can't access this page! Invalid login."
        redirect_to "/404.html"
      rescue => exception
        puts "ERROR! -> #{exception}"
      end
    end

    # Only allow a list of trusted parameters through.
    def subscription_params
      params.require(:subscription).permit(:user, :subscription_name, :username, :password, :url, :cost_per_month, :image)
    end
end
