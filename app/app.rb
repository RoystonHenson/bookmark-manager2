ENV["RACK_ENV"] ||= 'development'

require 'sinatra/base'
require_relative './models/link.rb'

DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}")

DataMapper.finalize

DataMapper.auto_upgrade!

class BookmarkManager < Sinatra::Base
  get '/' do
    erb :index
  end

  get '/links' do
    @links = Link.all
    erb :links
  end

  post "/links" do
    link = Link.create(url: "#{params[:url]}", title: "#{params[:title]}")
    tag = Tag.first_or_create(tag_name: "#{params[:tag]}")
    link.tags << tag
    link.save
    redirect "/links"
  end

  get "/links/new" do
    erb :add_link
  end

  get "/tags/:name" do
    @links = Link.all(:tags => { :tag_name => params[:name] })
    erb :links
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
