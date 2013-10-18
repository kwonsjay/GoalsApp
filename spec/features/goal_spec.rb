require 'spec_helper'

describe "goal operations" do

  before(:each) do
    visit new_user_url
    fill_in('Username', :with => 'Ned')
    fill_in('Password', :with => 'password')
    first(:button, "sign-up").click

    click_button('Create Goal')
    fill_in('Title', :with => 'Feed my cat')
    fill_in('Body', :with => 'Happy cats make me happy')
    click_button("Let's do this!")

  end

  it "creates goals" do
    expect(page).to have_content("Feed my cat")
  end

  it "updates goals" do
    click_button('Update Goal')
    fill_in('Title', :with => 'Feed my cat again')
    fill_in('Body', :with => 'Happy cats make me happy perpetually')
    click_button("Let's do this!")
    expect(page).to have_content("Feed my cat again")
  end

  it "deletes goals" do
    click_button('Delete Goal')
    page.should_not have_content("Feed my cat")
  end

end


describe "it lists goals on user show page" do

  before(:each) do
    visit new_user_url
    fill_in('Username', :with => 'Kush')
    fill_in('Password', :with => 'password')
    first(:button, "sign-up").click

    click_button('Create Goal')
    fill_in('Title', :with => 'Pet my cat')
    fill_in('Body', :with => 'Purring cats make me happy')
    check('Private')
    click_button("Let's do this!")
    click_button("Sign Out")

    visit new_user_url
    fill_in('Username', :with => 'Ned')
    fill_in('Password', :with => 'password')
    first(:button, "sign-up").click

    click_button('Create Goal')
    fill_in('Title', :with => 'Feed my cat')
    fill_in('Body', :with => 'Happy cats make me happy')
    check('Private')
    click_button("Let's do this!")
  end

  it "shows all goals if user is looking at own page" do
    expect(page).to have_content("Feed my cat")
  end

  it "shows only public goals if user is not looking at own page" do
    visit users_url
    click_link("Kush")
    page.should_not have_content("Pet my cat")
  end

end

