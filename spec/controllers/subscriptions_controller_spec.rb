require 'rails_helper'

# Change this ArticlesController to your project
RSpec.describe SubscriptionsController, type: :controller do

	login_user

	let(:valid_attributes) {
        { :user => controller.current_user, :subscription_name => "Netflix", :username => "freeguy", :password => "supersecurepass", :url => "https://netflix.com", :cost_per_month => 9.99, :image => "thisisanimage.png" }
    }

	let(:valid_attributes_no_user) {
        { :subscription_name => "Netflix", :username => "freeguy", :password => "supersecurepass", :url => "https://netflix.com", :cost_per_month => 9.99, :image => "thisisanimage.png" }
    }

	let(:invalid_attributes) {
		{:subscription_name => "Netflix", :username => 2, :cost_per_month => 9.99, :image => "thisisanimage.png" }
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
            subscription = Subscription.create! valid_attributes
            redirect_to subscriptions_path(subscription.id)
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
            subscription = Subscription.create! valid_attributes
            redirect_to edit_subscription_path(subscription.id)
            expect(response).to be_successful # be_successful expects a HTTP Status code of 200
        end
    end

    describe "POST /create" do
		context 'with valid parameters' do
			it "creates a new Subscription" do
				expect do
					post :create, params: {subscription: valid_attributes_no_user}, session: valid_session
				end.to change(Subscription, :count).by(1)
			end
		end

		context 'with invalid parameters' do
			it 'does not create a new Subscription' do
				expect do
					post :create, params: {subscription: invalid_attributes}, session: valid_session
				end.to change(Subscription, :count).by(0)
			end
		end
    end

	describe 'DELETE /destroy' do
		it 'destroys the requested Subscription' do
			subscription = Subscription.create!(valid_attributes)
			expect do
				delete :destroy, params: {id: subscription.id}
			end.to change(Subscription, :count).by(-1)
		end

		it 'redirects to the Subscriptions list' do
			subscription = Subscription.new(valid_attributes_no_user)
			subscription.user = controller.current_user
			subscription.save
			delete :destroy, params: {id: subscription.id}
			expect(response).to redirect_to(subscription_root_url)
		end
	end
end