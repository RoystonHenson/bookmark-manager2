require 'spec_helper'

feature 'Add tags to new link' do
  scenario 'when creating a new link' do
    visit '/links/new'
    fill_in('title', with: 'Kitten Academy')
    fill_in('url', with: 'http://www.kittenacademy.com')
    fill_in('tag', with: 'kittens')
    click_button('Add')
    expect(page).to have_content('kittens')
  end
end
