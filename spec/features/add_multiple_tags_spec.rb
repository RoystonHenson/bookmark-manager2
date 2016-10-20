require 'spec_helper'


feature 'Add tags to new link' do
  scenario 'when creating a new link' do
    visit '/links/new'
    fill_in('title', with: 'Kitten Academy')
    fill_in('url', with: 'http://www.kittenacademy.com')
    fill_in('tag', with: 'kittens cats')
    click_button('Add')
    link = Link.first
    expect(link.tags.map(&:tag_name)).to include('kittens', 'cats')
  end
end
