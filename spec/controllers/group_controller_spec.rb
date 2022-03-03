require 'rails_helper'

# Change this ArticlesController to your project
RSpec.describe GroupsController, type: :controller do

	login_user

	group_member = FactoryBot.create(:user)
    
	let(:valid_attributes) {
        { :owner => controller.current_user, :group_name => "Roomies" }
    }
    
	let(:valid_attributes_no_user) {
        { :group_name => "Roomies"}
    }
    
	let(:valid_attributes_members) {
        { :owner => controller.current_user, :group_name => "Roomies", :users => [group_member]}
    }
    
	let(:valid_attributes_no_user_members) {
        { :group_name => "Roomies", :users => [group_member]}
    }

	let(:invalid_attributes) {
		{:cost_per_month => 9.99}
	}

    let(:valid_session) { {} }

    describe "GET /index" do
        it "returns a success response" do
            get :index, params: {}, session: valid_session
            expect(response).to be_successful # be_successful expects a HTTP Status code of 200
        end
    end

    describe "GET /show" do
		context
        it "returns a success response without members" do
            group = Group.create! valid_attributes
            redirect_to groups_path(group.id)
            expect(response).to be_successful # be_successful expects a HTTP Status code of 200
        end
        it "returns a success response with members" do
            group = Group.create! valid_attributes_members
            redirect_to groups_path(group.id)
            expect(response).to be_successful # be_successful expects a HTTP Status code of 200
        end
    end

    describe "GET /new" do
        it "returns a success response" do
            get :new, params: {}, session: valid_session
            expect(response).to be_successful # be_successful expects a HTTP Status code of 200
        end
    end

    describe "GET /edit" do
        it "returns a success response" do
            group = Group.create! valid_attributes
            redirect_to edit_group_path(group.id)
            expect(response).to be_successful # be_successful expects a HTTP Status code of 200
        end
        it "returns a success response with members" do
            group = Group.create! valid_attributes_members
            redirect_to edit_group_path(group.id)
            expect(response).to be_successful # be_successful expects a HTTP Status code of 200
        end
    end

    describe "POST /create" do
		context 'with valid parameters' do
			it "creates a new Group" do
				expect do
					post :create, params: {group: valid_attributes_no_user}, session: valid_session
				end.to change(Group, :count).by(1)
			end
		end
		
		context 'with valid parameters and members' do
			it "creates a new Group" do
				expect do
					post :create, params: {group: valid_attributes_no_user_members}, session: valid_session
				end.to change(Group, :count).by(1)
			end
		end

		context 'with invalid parameters' do
			it 'does not create a new Group' do
				expect do
					post :create, params: {group: invalid_attributes}, session: valid_session
				end.to change(Group, :count).by(0)
			end
		end
    end

	describe 'DELETE /destroy' do
		it 'destroys the requested Group' do
			group = Group.create!(valid_attributes)
			expect do
				delete :destroy, params: {id: group.id}
			end.to change(Group, :count).by(-1)
		end
	
		it 'redirects to the Group list' do
			group = Group.new(valid_attributes_no_user)
			group.owner = controller.current_user
			group.save
			delete :destroy, params: {id: group.id}
			expect(response).to redirect_to(group_root_url)
		end
	end
end