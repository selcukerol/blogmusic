#app.rb

require "sinatra"
require "active_record"
require "sinatra/activerecord"
require 'sinatra/flash'
require "./models"

set :database, "sqlite3:wdi.db"

enable :sessions

before do
  current_user
end

get '/' do
    erb :home 
end

get '/login' do
    erb :login
end

get '/post' do
  if @current_user
    erb :post
  else
    redirect '/'
  end
end

get '/logout' do
  session.destroy
  flash[:notice] = "You are now logged out"
  redirect '/login'
end    

post '/login' do
  @user = User.where("fname = '#{params[:fname]}'").first

 p params

 if @user && @user.password == params[:password] && @user.email == params[:email]
   # "WELCOME #{@user.fname}!"
    session[:user_id] = @user.id
    flash[:notice] = "You successfully logged in!"
  else
    flash[:notice] = "Invalid username or password"
  end
  redirect '/post'
end

def current_user
  if session[:user_id]
    @current_user = User.find(session[:user_id])
    # just like:
    # User.where("id = '#{session[:user_id]}'")
  end
end

post '/post' do
  @post = Post.create (params[:post])
end