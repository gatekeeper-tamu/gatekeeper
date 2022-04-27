require 'rails_helper'

RSpec.feature 'Statistics for non-users', type: :feature do
  it 'shows the sitewide statistics page for non-user' do
    visit statistics_path
    expect(page).to have_content('Sitewide Statistics')
  end
end

RSpec.feature 'Sitewide statistics for users', type: :feature do
  it 'shows the sitewide statistics page for logged-in users' do
    login_as(FactoryBot.create(:user))
    visit statistics_path
    page.find("#sitewide-tab").click
    expect(page).to have_content('Sitewide Statistics')
  end
end

RSpec.feature 'Group statistics for users', type: :feature do
  it 'shows the group statistics page for logged-in users' do
    login_as(FactoryBot.create(:user))
    visit statistics_path
    page.find("#group-tab").click
    expect(page).to have_content('Group Statistics')
  end
end

RSpec.feature 'Personal statistics for users', type: :feature do
  it 'shows the personal statistics page for logged-in users' do
    login_as(FactoryBot.create(:user))
    visit statistics_path
    page.find("#personal-tab").click
    expect(page).to have_content('Personal Statistics')
  end
end
