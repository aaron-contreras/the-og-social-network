require 'rails_helper'

RSpec.describe "SignUps", type: :system do
  before do
    driven_by(:rack_test)
  end

  before(:each) do
    RegistrationMailer.deliveries = []
  end

  it 'sends an email to user upon succesful sign up' do
    visit new_user_registration_path
    fill_in('Name', with: 'John Doe')
    fill_in('Email', with: 'jd@example.com')
    fill_in('Password', with: 'foobar')
    fill_in('Password confirmation', with: 'foobar')
    click_button('Sign up')
    expect(page).to have_current_path(root_path)
    expect(RegistrationMailer.deliveries.last.to).to eq(%w[jd@example.com])
  end

  it "doesn't send an email to user upon succesful sign up" do
    visit new_user_registration_path
    fill_in('Email', with: 'jd@example.com')
    fill_in('Password', with: 'foobar')
    fill_in('Password confirmation', with: 'foobar')
    click_button('Sign up')
    expect(page).not_to have_current_path(root_path)
    expect(RegistrationMailer.deliveries).to be_empty
  end
end
