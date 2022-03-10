require "application_system_test_case"

class SubscriptionsTest < ApplicationSystemTestCase
  setup do
    @subscription = subscriptions(:one)
  end

  test "visiting the index" do
    visit subscriptions_url
    assert_selector "h1", text: "Subscriptions"
  end

  test "creating a Subscription" do
    visit subscriptions_url
    click_on "New Subscription"

    fill_in "Cost per month", with: @subscription.cost_per_month
    fill_in "Encrypted password", with: @subscription.encrypted_password
    fill_in "Encrypted username", with: @subscription.encrypted_username
    fill_in "Image", with: @subscription.image
    fill_in "Name", with: @subscription.subscription_name
    fill_in "Url", with: @subscription.url
    fill_in "User", with: @subscription.user
    click_on "Create Subscription"

    assert_text "Subscription was successfully created"
    click_on "Back"
  end

  test "updating a Subscription" do
    visit subscriptions_url
    click_on "Edit", match: :first

    fill_in "Cost per month", with: @subscription.cost_per_month
    fill_in "Encrypted password", with: @subscription.encrypted_password
    fill_in "Encrypted username", with: @subscription.encrypted_username
    fill_in "Image", with: @subscription.image
    fill_in "Name", with: @subscription.subscription_name
    fill_in "Url", with: @subscription.url
    fill_in "User", with: @subscription.user
    click_on "Update Subscription"

    assert_text "Subscription was successfully updated"
    click_on "Back"
  end

  test "destroying a Subscription" do
    visit subscriptions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Subscription was successfully destroyed"
  end
end
