require 'rails_helper'

RSpec.describe "Friendings", type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'when in the find new friends page' do
    context 'when a user is not currently a friend' do
      it 'can send a friend request' do
        user = FactoryBot.create(:user)
        friend = FactoryBot.create(:user, name: 'Timmy Turner',
                                          email: 'timmyturner@example.com')
        visit new_user_session_path
        fill_in('Email', with: user.email)
        fill_in('Password', with: user.password)
        click_button 'Log in'
        click_on 'Find new friends'
        expect(page).to have_content(friend.name)
        expect { click_button 'Send friend request' }.to change { FriendRequest.count }.by(1) 
        expect(page).not_to have_content('Send friend request')
      end
    end

    context 'when a user has sent a request and is still pending' do
      it 'can cancel a friend request' do
        user = FactoryBot.create(:user)
        friend = FactoryBot.create(:user, name: 'Timmy Turner',
                                          email: 'timmyturner@example.com')
        visit new_user_session_path
        fill_in('Email', with: user.email)
        fill_in('Password', with: user.password)
        click_button 'Log in'
        click_on 'Find new friends'
        expect(page).to have_content(friend.name)
        expect { click_button 'Send friend request' }.to change { FriendRequest.count }.by(1) 
        expect { click_button 'Cancel friend request' }.to change { FriendRequest.count }.by(-1)
      end
    end
  end
end
