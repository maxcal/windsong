require 'spec_helper'

feature "Internationalization" do

  background do

  end

  scenario 'when I visit the /sv homepage' do
    visit '/sv'
    expect(page).to have_content 'Hem'
  end
end