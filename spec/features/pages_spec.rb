require 'spec_helper'

feature 'Pages' do

  describe "Home" do
    scenario "when I visit the root page" do
      visit '/'
      expect(page).to have_title 'Windsong'
    end
  end
end