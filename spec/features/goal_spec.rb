require 'spec_helper'

describe "goal operations" do

  before(:each) do
    visit new_user_url
    fill_in('Username', :with => 'Ned')
    fill_in('Password', :with => 'password')
    first(:button, "sign-up").click

    click_button('Create Goal')
    fill_in('Title', :with => 'Feed my cat')
    fill_in('Description', :with => 'Happy cats make me happy')
    click_button("Let's do this!")

  end

  it "creates goals" do
    expect(page).to have_content("Feed my cat")
  end

  it "updates goals" do
    click_link("Feed my cat")
    click_button('Edit Goal')
    fill_in('Title', :with => 'Feed my cat again')
    fill_in('Description', :with => 'Happy cats make me happy perpetually')
    click_button("Update Goal")
    expect(page).to have_content("Feed my cat again")
  end

  it "deletes goals" do
    click_link("Feed my cat")
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
    fill_in('Description', :with => 'Purring cats make me happy')
    check('Private')
    click_button("Let's do this!")
    click_button("Sign Out")

    visit new_user_url
    fill_in('Username', :with => 'Ned')
    fill_in('Password', :with => 'password')
    first(:button, "sign-up").click

    click_button('Create Goal')
    fill_in('Title', :with => 'Feed my cat')
    fill_in('Description', :with => 'Happy cats make me happy')
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


describe "it tracks number of user cheers" do

  before(:each) do
    visit new_user_url
    fill_in('Username', :with => 'Kush')
    fill_in('Password', :with => 'password')
    first(:button, "sign-up").click

    click_button('Create Goal')
    fill_in('Title', :with => 'Pet my cat')
    fill_in('Description', :with => 'Purring cats make me happy')
    click_button("Let's do this!")
    click_button("Sign Out")

    visit new_user_url
    fill_in('Username', :with => 'Ned')
    fill_in('Password', :with => 'password')
    first(:button, "sign-up").click

    visit users_url
    click_link("Kush")
    click_link("Pet my cat")
  end

  it "lists cheer element on show page" do
    expect(page).to have_content("Cheers")
  end

  it "increments cheer on user click cheer" do
    expect(page).to have_content("0")
    click_button("Cheer")
    expect(page).to have_content("1")
  end

  it "limits user cheers to 5 a day" do
    5.times do
      click_button("Cheer")
    end
    expect(page).to have_content("5")
    click_button("Cheer")
    expect(page).to have_content("No more cheers for today!")
  end

  it "prevents user from cheering own goal" do
    visit users_url
    click_link("Ned")
    click_button('Create Goal')
    fill_in('Title', :with => 'Bathe my cat')
    fill_in('Description', :with => 'Ouch!')
    click_button("Let's do this!")
    page.should_not have_button("Cheer")
  end

  it "doesn't track cheers for private goals" do
    visit users_url
    click_link("Kush")
    click_button('Create Goal')
    fill_in('Title', :with => 'Bathe my dog')
    fill_in('Description', :with => 'Fun!')
    check("Private")
    click_button("Let's do this!")
    expect(page).to have_content("Private")
    page.should_not have_content("Cheers")
  end

end