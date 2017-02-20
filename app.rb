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
  @posts = Post.all
  # @current_user = current_user
  # @user.id = session[:user_id]
	erb :home 
end

get '/login' do
	erb :login
end

get '/signup' do
  erb :signup
end

get '/post' do
  if @current_user
    erb :post
  else
    redirect '/'
  end
end

get '/post/:id' do
  @post = Post.find(params[:id])
  redirect '/post' unless @post
  erb '/post/detail'.to_sym
end


get '/logout' do
  session.destroy
  flash[:notice] = "You are now logged out"
  redirect '/login'
end	

post '/login' do
  @user = User.where("username = '#{params[:username]}'").first

  p params

  if @user && @user.password == params[:password]
   # "WELCOME #{@user.fname}!"
    session[:user_id] = @user.id
    redirect '/post'
  else
    flash[:notice] = "Invalid username or password"
    redirect '/login'
  end
end

post '/signup' do
  @newuser = User.create(params[:user])
  redirect '/login'

end  

def current_user
  if session[:user_id]
    @current_user = User.find(session[:user_id])
    # just like:
    # User.where("id = '#{session[:user_id]}'")
  end
end

post '/post' do
  @post = Post.create(params[:post])
  flash[:alert] = "Thanks for the post!!!"
  redirect '/post'
end





