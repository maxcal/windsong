require 'spec_helper'

feature "breadcrumbs" do

  let!(:station){ create(:station) }

  scenario "when I click the 'home' breadcrumb on a station page" do
    visit(station_url(station))
    within ".breadcrumbs" do
      click_link "Home"
    end
    expect(current_path).to eq(root_path)
  end

  scenario "when I click the 'Stations' breadcrumb on a station page" do
    visit(station_url(station))
    within ".breadcrumbs" do
      click_link "Stations"
    end
    expect(current_path).to eq(stations_path)
  end

  scenario "when I view a station it should have the name in the breadcrumbs" do
    visit(station_url(station))
    within ".breadcrumbs" do
      expect(page).to have_link(station.name)
    end
  end

  scenario "when I view my profile" do
    user = create_user_and_sign_in
    visit(current_user_path)
    expect(page).to have_link('Users')
    expect(page).to have_link('My profile')
  end

end