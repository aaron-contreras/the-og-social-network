require 'rails_helper'

RSpec.describe "LogIns", type: :system do
  before do
    driven_by(:rack_test)
  end

  context "when user's credentials are correct"  do
    it 'logs in the user' do
      user = FactoryBot.create(:user)
      visit new_user_session_path
      fill_in('Email', with: user.email)
      fill_in('Password', with: user.password)
      click_button 'Log in'
      expect(page).to have_current_path(root_path)
      expect(page).to have_content('successfully')
    end
  end

  context "when credentials are incorrect"  do
    context 'when email is wrong' do
      it "doesn't log the user in" do
        user = FactoryBot.create(:user)
        visit new_user_session_path
        fill_in('Email', with: "#{user.email}1")
        fill_in('Password', with: user.password)
        click_button 'Log in'
        expect(page).to have_current_path(new_user_session_path)
        expect(page).to have_content('Invalid')
      end
    end

    context 'when password is wrong' do
      it "doesn't log the user in" do
        user = FactoryBot.create(:user)
        visit new_user_session_path
        fill_in('Email', with: user.email)
        fill_in('Password', with: "#{user.password}1")
        click_button 'Log in'
        expect(page).to have_current_path(new_user_session_path)
        expect(page).to have_content('Invalid')
      end
    end
  end
end
