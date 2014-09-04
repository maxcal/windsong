require 'spec_helper'

feature "Internationalization" do

  background do

  end

  scenario 'when I visit the /se homepage' do
    visit '/se'
    expect(page).to have_content 'Hem'
  end
end