require 'rails_helper'
require 'capybara/rails'

RSpec.describe "StaticPages", type: :request do

  # describe "GET /home" do
  #   it "returns http success" do
  #     get "/static_pages/home"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /help" do
  #   it "returns http success" do
  #     get "/static_pages/help"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET /about" do
  #   it "returns http success" do
  #     get "/static_pages/about"
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  describe "About Page" do 
    before {visit about_path}
    
    it { should have_selector('h1', text: 'About Us') }
    it { should have_selector('title', text: full_title('About Us')) }
  end

  describe "Contact Page" do 
    before {visit contact_path}
    
    it { should have_selector('h1', text: 'Contact') }
    it { should have_selector('title', text: full_title('Contact')) }
  end

  it "should have right links on the layout" do
    visit root_path
    click_link "About"
    page.should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    click_link "Sign up now"
    page.should have_selector 'title', text: full_title('Sign up')
    click_link "sample app"
    page.should have_selector 'h1', text: 'Sample App'
  end
end
