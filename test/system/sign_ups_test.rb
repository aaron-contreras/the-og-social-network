require "application_system_test_case"

class SignUpsTest < ApplicationSystemTestCase
  describe 'succesful signup sends user an email' do
    visit new_user_registration_path
  end
end
