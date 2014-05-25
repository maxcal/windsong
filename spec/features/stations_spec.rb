require 'spec_helper'

feature "Stations" do

  let!(:admin) { create(:admin) }
  before(:each) do
    sign_in_user(admin) if example.metadata[:authorized]
  end

  context "creating a new station", authorized: true do

    scenario "when I fill in form with invalid information" do
      visit new_station_path
      click_button 'Create'
      expect(page).to have_content "Namecan't be blank"
      expect(page).to have_content "Hardware uidcan't be blank"
    end

    scenario "when I fill in form with valid information" do
      visit new_station_path
      fill_in 'Name', with: 'Foo'
      fill_in 'Hardware uid', with: 'ABC123'
      click_button 'Create'
      expect(Station.count).to eq 1
      expect(current_path).to eq station_path(Station.last.to_param)
    end
  end

  context "viewing stations" do
    let!(:station) { create(:station) }

    scenario "when I view stations index" do
      visit stations_path
      click_link station.name
      expect(page).to have_content station.name
      expect(current_path).to eq station_path(station.to_param)
    end
  end

end