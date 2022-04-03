class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscription, only: %i[ show edit update destroy share ]

  # GET /subscriptions or /subscriptions.json
  def index
    @subscriptions = current_user.subscriptions
    # @groups = current_user.owned_groups.sort_by(&:group_name)
    @groups = (current_user.owned_groups | current_user.groups).sort_by(&:group_name)
  end

  # GET /subscriptions/1 or /subscriptions/1.json
  def show
    if (!@subscription.can_view?(current_user))
      puts "Can't access this page! Invalid login."
      redirect_to "/404.html"
    end
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
    @subscription.user = current_user
  end

  # GET /subscriptions/1/edit
  def edit
    if (!@subscription.can_edit?(current_user))
      puts "Can't access this page! Invalid login."
      redirect_to "/404.html"
    end
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
    if (!@subscription.can_edit?(current_user))
      puts "Can't access this page! Invalid login."
      redirect_to "/404.html"
    end
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
    if (!@subscription.can_edit?(current_user))
      puts "Can't access this page! Invalid login."
      redirect_to "/404.html"
    end
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: "Subscription was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def share
    if (!@subscription.user == current_user)
      puts "Can't access this page! Invalid login. SHARE_SUBSCRIPTION"
      redirect_to "/404.html"
    end

    respond_to do |format|
      if (TempSharedSubscription.create(subscription: @subscription))
        format.html { redirect_to "/subscriptions/#{@subscription.id}", notice: "Share link successfully generated." }
        format.json { head :no_content }
      else
        format.html { redirect_to "/subscriptions/#{@subscription.id}", notice: "Share link could not be generated." }
        format.json { render json: @subscription.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      begin
        @subscription = Subscription.accessible_by_user(current_user).find(params[:id])
      rescue ActiveRecord::RecordNotFound
        puts "Can't access this page! Invalid login. SET_SUBSCRIPTION"
        redirect_to "/404.html"
      end
    end

    # Only allow a list of trusted parameters through.
    def subscription_params
      params.require(:subscription).permit(:user, :subscription_name, :username, :password, :url, :cost_per_month, :image,
        :share_records_attributes, {:share_records_attributes => [:id, :_destroy, :group_id, :permission]})
    end
end
