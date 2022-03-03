require 'rails_helper'

# Change this ArticlesController to your project
RSpec.describe RemindersController, type: :controller do

	login_user

	reminder_member = FactoryBot.create(:user)
    
	let(:valid_attributes) {
        {}
    }
	
	let(:invalid_attributes) {
		{}
	}

    let(:valid_session) { {} }

    describe "GET /index" do
        it "returns a success response" do
            get :index, params: {}, session: valid_session
            expect(response).to be_successful # be_successful expects a HTTP Status code of 200
        end
    end

    describe "GET /show" do
        it "returns a success response"
    end

    describe "GET /new" do
        it "returns a success response"
    end

    describe "GET /edit" do
        it "returns a success response"
    end

    describe "POST /create" do
		context 'with valid parameters' do
			it "creates a new Reminder"
		end

		context 'with invalid parameters' do
			it 'does not create a new Reminder'
		end
    end

	describe 'DELETE /destroy' do
		it 'destroys the requested Reminder'
	
		it 'redirects to the posts list'
	end
end