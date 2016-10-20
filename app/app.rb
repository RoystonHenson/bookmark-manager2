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
    params[:tag].split.each do |tag|
      link.tags << Tag.create(tag_name: tag)
    end
    link.save
    redirect "/links"
  end

  get "/links/new" do
    erb :add_link
  end


  get '/tags/:name' do
  tag = Tag.all(tag_name: params[:name])
  @links = tag ? tag.links : []
  erb :links
end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
