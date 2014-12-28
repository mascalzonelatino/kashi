require 'spec_helper.rb'

feature "Viewing a song", js: true do
  before do
    Song.create!(name: 'Human Nature', 
           lyrics: "Reaching out across the night time")
  end
  scenario "view one song" do
    visit '/'
    fill_in "keywords", with: "human"
    click_on "Search"

    click_on "Human Nature"

    expect(page).to have_content("Reaching out across the night time")

    click_on "Back"

    expect(page).to     have_content("Human Nature")
  end
end
