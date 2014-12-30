require 'spec_helper.rb'

feature "Creating, editing, and deleting a song", js: true do
  scenario "CRUD a song" do
    visit '/'
    click_on "New Song"

    fill_in "name", with: "Human Nature"
    fill_in "lyrics", with: "Reaching out across the night time"

    click_on "Save"

    expect(page).to have_content("Human Nature")
    expect(page).to have_content("Reaching out across the night time")

    click_on "Edit"

    fill_in "name", with: "Human Nature"
    fill_in "lyrics", with: "Looking out across the night-time"

    click_on "Save"

    expect(page).to have_content("Human Nature")
    expect(page).to have_content("Looking")

    visit "/"
    fill_in "keywords", with: "Looking out"
    click_on "Search"

    click_on "Human Nature"

    click_on "Delete"

    expect(Song.find_by_name("Human Nature")).to be_nil

  end
end
