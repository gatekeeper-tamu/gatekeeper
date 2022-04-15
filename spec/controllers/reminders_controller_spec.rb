require 'rails_helper'

# Change this ArticlesController to your project
RSpec.describe RemindersController, type: :controller do

	login_user

    before (:each) do
        FactoryBot.create(:subscription, user: controller.current_user)
    end

    let(:valid_attributes) {
        { :subscription_id => controller.current_user.subscriptions.first.id, :recurring => "True", :reminder_type => "Billing", :frequency => "Monthly", :end_date => DateTime.now, :notification_time => "2 days before" }
    }

	let(:valid_attributes_no_subscription) {
        { :recurring => "True", :reminder_type => "Billing", :frequency => "Monthly", :end_date => DateTime.now, :notification_time => "2 days before" }
    }

    let(:invalid_attributes) {
		{ :subscription_id => controller.current_user.subscriptions.first.id, :recurring => "True", :reminder_type => "Billing", :notification_time => "2 days before" }
	}

    let(:valid_session) { {} }

    describe "GET /index" do
        it "returns a success response" do
            get :index, params: {}, session: valid_session
            expect(response).to be_successful # be_successful expects a HTTP Status code of 200
        end
    end

    describe "GET /show" do
        it "returns a success response" do
            reminder = Reminder.create! valid_attributes
            redirect_to reminders_path(reminder.id)
        end
    end

    describe "GET /new" do
        it "returns a success response" do 
            get :new, params: {}, session: valid_session
            expect(response).to be_successful
        end
    end

    describe "GET /edit" do
        it "returns a success response" do
            reminder = Reminder.create! valid_attributes
            redirect_to edit_reminder_path(reminder.id)
            expect(response).to be_successful
        end
    end

    describe "POST /create" do
		context 'with valid parameters' do
			it "creates a new Reminder" do
                expect do
                    post :create, params: { reminder: valid_attributes }
                end
            end
		end

		context 'with invalid parameters' do
			it 'does not create a new Reminder' do
                expect do
                    post :create, params: { reminder: invalid_attributes }, session: valid_session
                end
            end
		end
    end

	describe 'DELETE /destroy' do
		it 'destroys the requested Reminder' do
            reminder = Reminder.create!(valid_attributes)
            expect do
                delete :destroy, params: {id: reminder.id}
            end
        end 

		it 'redirects to the posts list' do
            reminder = Reminder.new(valid_attributes)
            reminder.save
            delete :destroy, params: {id: reminder.id}
            expect(response).to redirect_to(subscription_root_url)
        end
	end
end