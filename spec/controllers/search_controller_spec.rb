require 'rails_helper'
require 'webdrivers'
require 'spec_helper'
RSpec.describe SearchController, type: :controller do

    describe "GET /search" do
        it "displays search page successfully " do
            redirect_to '/search'
            expect(response).to be_successful
        end
        
    end

    describe "POST /search/show" do
        it "returns show or movie results successfully" do
            redirect_to '/search'
            fill_in 'search[title]', with: 'Riverdale', disabled: true
            expect(page).to have_content 'Search Results'
        end
        
    end

end