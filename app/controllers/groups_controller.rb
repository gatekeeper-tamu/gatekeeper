class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, only: %i[ show edit update destroy ]

  # GET /groups or /groups.json
  def index
    @groups = current_user.owned_groups.concat(current_user.groups).sort_by(&:group_name)
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
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
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
        subscription ||= current_user.subscriptions.find(group_params[:subscription_ids].second)
        if !subscription.nil? && @group.subscriptions << subscription
          format.html { redirect_to group_url(@group), notice: "Group was successfully updated." }
          format.json { render :show, status: :ok, location: @group }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @group.errors, status: :unprocessable_entity }
        end
      elsif (group_params[:update_action] == "remove")
        puts "REMOVING SUBSCRIPTION"
        subscription ||= current_user.subscriptions.find(group_params[:subscription_ids].first)
        if !subscription.nil? && @group.subscriptions.delete(subscription)
          format.html { redirect_to group_url(@group), notice: "Group was successfully updated." }
          format.json { render :show, status: :ok, location: @group }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @group.errors, status: :unprocessable_entity }
        end
      else
        if @group.update(group_params)
          format.html { redirect_to group_url(@group), notice: "Group was successfully updated." }
          format.json { render :show, status: :ok, location: @group }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @group.errors, status: :unprocessable_entity }
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
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      begin
        @group = current_user.owned_groups.find(params[:id])
      rescue ActiveRecord::RecordNotFound => e
        puts "Can't access this page! Invalid login."
        redirect_to "/404.html"
      rescue => exception
        puts "ERROR! -> #{exception}"
      end
      
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:group_name, {user_ids: []}, :user_ids, :subscription_id, {subscription_ids: []}, :subscription_ids, :update_action)
    end
end
