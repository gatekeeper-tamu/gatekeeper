class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group, except: %i[ create new  ]
  before_action :set_self_owner, only: %i[ create new ]

  # GET /groups or /groups.json
  def index
  end

  # GET /groups/1 or /groups/1.json
  def show
    if !current_user.is_viewer?(@group)
      puts "Can't access this page! Invalid login."
      redirect_to "/404.html"
    end
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
    if !current_user.is_collaborator?(@group)
      puts "Can't access this page! Invalid login."
      redirect_to "/404.html"
    end
  end

  # POST /groups or /groups.json
  def create
    @group = Group.new(create_params)
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
    return unless (current_user.is_collaborator?(@group))
    respond_to do |format|
      if (update_params[:update_action] == "add")
        puts "ADDING SUBSCRIPTION"
        add_subscription(update_params[:subscription_ids].second, format)
      elsif (update_params[:update_action] == "remove")
        puts "REMOVING SUBSCRIPTION"
        remove_subscription(update_params[:subscription_ids].first, format)
      else
        if @group.update(update_params)
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
    if (!current_user.is_owner?(@group))
      puts "Can't access this page! Invalid login."
      redirect_to "/404.html"
    end
    @group.destroy

    respond_to do |format|
      format.html { redirect_to groups_url, notice: "Group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def add_subscription(subscription_id, format)
      if (current_user.is_collaborator?(@group))
        subscription ||= current_user.subscriptions.find(subscription_id)
        sub_name = subscription.subscription_name
        if !subscription.nil? && @group.subscriptions << subscription
          format.html { redirect_to group_url(@group), notice: "#{sub_name} subscription successfully added." }
          format.json { render :show, status: :ok, location: @group }
        else
          render_errors(format)
        end
      else
        render_errors(format)
      end
    end

    def remove_subscription(subscription_id, format)
      subscription ||= Subscription.find(subscription_id)
      return if (subscription.nil?)
      if (current_user.is_admin?(@group) || current_user == subscription.user)
        sub_name = subscription.subscription_name
        if !subscription.nil? && @group.subscriptions.delete(subscription)
          format.html { redirect_to group_url(@group), notice: "#{sub_name} subscription successfully removed." }
          format.json { render :show, status: :ok, location: @group }
        else
          render_errors(format)
        end
      else
        render_errors(format)
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_group
      begin
        @groups = Group.accessible_by_user(current_user)
        if (params[:id].present?)
          @group = @groups.find(params[:id])
          @owner = @group.owner
        end
        rescue ActiveRecord::RecordNotFound
          puts "Can't access this page! Invalid login."
          redirect_to "/404.html"
        end
      end
    end

    def set_self_owner
      @owner = current_user
    end

    # Only allow a list of trusted parameters through.
    def create_params
      params.require(:group).permit(:group_name, {user_ids: []}, :user_ids, :subscription_id, {subscription_ids: []}, :subscription_ids, :members_attributes, {:members_attributes => [:id, :_destroy, :user_id, :permission]}, :update_action)
    end

    def update_params
      params.compact!
      permission = @group.access_level(current_user)
      if (current_user.is_admin?(@group))
        puts params
        params.require(:group).permit(:group_name, {user_ids: []}, :user_ids, :subscription_id, {subscription_ids: []}, :subscription_ids, :members_attributes, {:members_attributes => [:id, :_destroy, :user_id, :permission]}, :update_action)
        # puts params
      elsif (current_user.is_collaborator?(@group))
        params.require(:group).permit(:subscription_id, {subscription_ids: []}, :subscription_ids, :update_action)
      elsif (current_user.is_viewer?(@group))
        params.require(:group).permit()
      end
      # return params
    end

    def render_errors(format)
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @group.errors, status: :unprocessable_entity }
    end
# end
