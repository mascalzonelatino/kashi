require 'spec_helper.rb'

feature "Looking up songs", js: true do
  scenario "finding songs" do
    visit '/'
    fill_in "keywords", with: "nature"
    click_on "Search"

    expect(page).to have_content("Human Nature")
  end
end
