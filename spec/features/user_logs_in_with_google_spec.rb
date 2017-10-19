require 'rails_helper'

def stub_omniauth
  # first, set OmniAuth to run in test mode
  OmniAuth.config.test_mode = true
  # then, provide a set of fake oauth data that
  # omniauth will use when a user tries to authenticate:
  OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
  	provider: "google",
  	     uid: "12345678910",
  	     info: {
  	       email: "elaine@mountainmantechnologies.com",
  	       first_name: "ELaine",
  	       last_name: "yip"
  	     },
  	     credentials: {
  	       token: "abcdefg12345",
  	       refresh_token: "12345abcdefg",
  	       expires_at: DateTime.now,
  	     }
  	   })
end

RSpec.feature 'user log in' do
	describe "the signin process", :type => :feature do

	  it "signs me in" do
	    visit '/login'
	    within("#sessions") do
	      fill_in 'Email', with: 'wkitsin99@hotmail.com'
	      fill_in 'Password', with: '1234'
	    end
	    click_button 'log in'
	    expect(page).to have_content 'Sign Out'
	  end
	end 

	scenario "using google oauth2" do
	  stub_omniauth
	  visit root_path
      expect(page).to have_link("Sign in with Google")
      click_link "Sign in with Google"
      expect(page).to have_link("Sign Out")
	end

end
