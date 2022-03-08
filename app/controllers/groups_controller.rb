class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[ show edit update destroy ]

  # GET /groups or /groups.json
  def index
    # @groups = current_user.owned_groups.sort_by(&:group_name)
    @groups = (current_user.owned_groups | current_user.groups).sort_by(&:group_name)
  end

  # GET /groups/1 or /groups/1.json
  def show
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups or /groups.json
  def create
    @group = Group.new(group_params)
    @group.owner = current_user

    respond_to do |format|
      if @group.save
        format.html { redirect_to group_url(@group), notice: "Group was successfully created." }
        format.json { render :show, status: :created, location: @group }
      else
        render_errors(format)
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      # puts "HELLO FROM UPDATE"
      # puts group_params
      if (group_params[:update_action] == "add")
        puts "ADDING SUBSCRIPTION"
        add_subscription(group_params[:subscription_ids].second, format)
      elsif (group_params[:update_action] == "remove")
        puts "REMOVING SUBSCRIPTION"
        remove_subscription(group_params[:subscription_ids].first, format)
      else
        if @group.update(group_params)
          format.html { redirect_to group_url(@group), notice: "Group was successfully updated." }
          format.json { render :show, status: :ok, location: @group }
        else
          render_errors(format)
        end
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url, notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def add_subscription(subscription_id, format)
      subscription ||= current_user.subscriptions.find(subscription_id)
      sub_name = subscription.subscription_name
      if !subscription.nil? && @group.subscriptions << subscription
        format.html { redirect_to group_url(@group), notice: "#{sub_name} subscription successfully added." }
        format.json { render :show, status: :ok, location: @group }
      else
        render_errors(format)
      end
    end
    
    def remove_subscription(subscription_id, format)
      subscription ||= current_user.subscriptions.find(subscription_id)
      sub_name = subscription.subscription_name
      if !subscription.nil? && @group.subscriptions.delete(subscription)
        format.html { redirect_to group_url(@group), notice: "#{sub_name} subscription successfully removed." }
        format.json { render :show, status: :ok, location: @group }
      else
        render_errors(format)
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_group
      begin
        @group = current_user.owned_groups.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        begin
          @group = current_user.groups.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
          puts "Can't access this page! Invalid login."
          redirect_to "/404.html"
        end
      end
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:group_name, {user_ids: []}, :user_ids, :subscription_id, {subscription_ids: []}, :subscription_ids, :members_attributes, {:members_attributes => [:id, :_destroy, :user_id, :permission]}, :update_action)
    end

    def render_errors(format)
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @group.errors, status: :unprocessable_entity }
    end
end
