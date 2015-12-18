ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base

  enable :sessions

  get "/signup" do
    erb :'signup'
  end

  post '/signup' do
    user = User.create(email: params[:email], password: params[:password])
    user.save
    session[:email] = params[:email]
    session[:password] = params[:password]
    redirect '/links'
  end

  get "/links" do
    @email = session[:email]
    @links = Link.all
    erb :'links/index'
  end

  get "/links/new" do
    erb :'links/new'
  end

  post "/links" do
    link = Link.new(url: params[:url], title: params[:title])
    params[:tags].split(', ').each do |tag|
      tag = Tag.create(name: tag)
      link.tags << tag
    end
    link.save
    redirect to('/links')
  end

  get '/tags/:name' do
    tag = Tag.all(name: params[:name])
    @links = tag ? tag.links : []
    erb(:'links/index')
  end

end
