require 'spec_helper'
require "./app/models/link"

describe "filter_links" do
  it "shows links filtered by tag" do
    visit '/links/new'
    fill_in('title', with: 'Kitten Academy')
    fill_in('url', with: 'http://www.kittenacademy.com')
    fill_in('tag', with: 'bubbles')
    click_button('Add')
    visit '/tags/bubbles'
    expect(page).to have_text('bubbles')
  end
end
