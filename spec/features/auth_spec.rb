require 'spec_helper'

describe "the signup process" do

  before(:each) do
    visit new_user_url
  end

  it "has a new user page" do
    expect(page).to have_content "Sign Up"
  end

  describe "signing up a user" do
    it "shows username on the homepage after signup" do
      fill_in('Username', :with => 'Ned')
      fill_in('Password', :with => 'password')
      save_and_open_page
      first(:button, "sign-up").click
      expect(page).to have_content("Ned")
    end

  end

end

describe "logging in" do

  before(:each) do
    visit new_user_url
    fill_in('Username', :with => 'Ned')
    fill_in('Password', :with => 'password')
    first(:button, "sign-up").click
    first(:button, "Sign Out").click
  end

  it "begins with logged out state" do
    visit new_session_url
    expect(page).to have_content("Sign In")
  end

  it "shows username on the homepage after login" do
    visit new_session_url
    fill_in('Username', :with => "Ned")
    fill_in('Password', :with => "password")
    first(:button, "sign-in").click
    expect(page).to have_content("Ned")
  end

end

describe "logging out" do

  before(:each) do
    visit new_user_url
    fill_in('Username', :with => "Ned")
    fill_in('Password', :with => "password")
    first(:button, "sign-up").click
  end

  it "doesn't show username on the homepage after logout" do
    click_button('Sign Out')
    page.should_not have_content("Ned")
  end

end