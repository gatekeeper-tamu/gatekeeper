require 'rails_helper'
require 'webdrivers'
require 'spec_helper'
RSpec.describe SearchController, type: :request do

    describe "GET /search" do
        it "displays search page successfully " do
            visit '/search'
            expect(page).to have_content 'TV show / movie search'
        end
    end

    describe "POST /search/show" do
        it "returns show or movie results successfully" do
            visit '/search'
            fill_in 'search_title', with: 'Riverdale'
            click_button "search"
            expect(page).to have_content 'Search Results'
        end
    end

end