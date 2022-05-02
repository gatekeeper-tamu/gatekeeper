require 'rails_helper'
require 'webdrivers'
require 'spec_helper'
RSpec.describe SearchController, type: :request do
    let(:valid_attributes) {
        { :network_name => "HBO MAX", :network_URL => "https://play.hbomax.com/episode/urn:hbo:episode:GXKOAMQ3qNcJzwwEAAAAU" }
    }
    describe "GET /search" do
        it "displays search page successfully " do
            visit '/search'
            expect(page).to have_content 'Search for a show or movie below to find streaming platforms!'
        end
    end

    describe "POST /search/show" do
        it "returns show or movie results successfully" do
            visit '/search'
            fill_in 'search_title', with: 'Euphoria'
            click_button "search"
            print page.body
            expect(page).to have_content 'Join our platform today'
        end
    end
    
    describe "#networksearch" do
        it "returns a success networks response" do
            visit '/search'
            SearchController.new.send(:networksearch, "3159756").should == "network search successful"
        end
    end
end