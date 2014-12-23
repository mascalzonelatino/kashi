require 'spec_helper.rb'

feature "Looking up songs", js: true do
  before do
    Song.create!(name: 'Human Nature')
    Song.create!(name: 'Careless Whisper')
    Song.create!(name: 'Lowdown')
    Song.create!(name: 'La Prima Estate')
  end
  scenario "finding songs" do
    visit '/'
    fill_in "keywords", with: "nature"
    click_on "Search"

    expect(page).to have_content("Human Nature")
  end
end
