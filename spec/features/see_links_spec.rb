require 'spec_helper'

feature 'See links' do
  scenario 'When user visits the site' do
    
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit '/links'
    find_link('makersacademy').visible?
  end
end
