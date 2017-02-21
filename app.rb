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
  erb :home 
end

get '/login' do
  erb :login
end

get '/signup' do
  erb :signup
end
# Edit profile 
get '/settings' do
  if session[:user_id]
    erb :settings
  end
end
# Create post for new user
get '/post' do
  if @current_user
    erb :post
  else
    redirect '/'
  end
end
# Create .erb for each post 
get '/post/:id' do
  @post = Post.find(params[:id])
  redirect '/post' unless @post
  erb '/post/detail'.to_sym
end

# Logout of your account
get '/logout' do
  session.destroy
  flash[:notice] = "You are now logged out"
  redirect '/login'
end 
# Login to your account
post '/login' do
  @user = User.where("username = '#{params[:username]}'").first

  if @user && @user.password == params[:password]
   # "WELCOME #{@user.fname}!"
   session[:user_id] = @user.id
   redirect '/post'
 else
  flash[:notice] = "Invalid username or password"
  redirect '/login'
end
end
# Create new user
post '/signup' do
  @newuser = User.create(params[:user])
  redirect '/login'

end  
# Create session 
def current_user
  if session[:user_id]
    @current_user = User.find(session[:user_id])
    # just like:
    # User.where("id = '#{session[:user_id]}'")
  end
end

post '/post' do
  @post = Post.new(params[:post])
  @post.user_id = @current_user.id
  @post.save
  redirect '/'
end

# Update current user info
post "/settings" do
 current_user.update(
 fname: params[:fname],
 lname: params[:lname],
 email: params[:email],
 username: params[:username]
 )
 # Update password if current password is correct
 if(current_user.password == params[:password] && params[:new_password].length > 0)
   current_user.update(
   password: params[:new_password]
   )
 end

 redirect "/"
end

# Delete user and posts
post "/delete-account" do
 current_user.posts.destroy_all
 current_user.destroy
 session[:user_id] = nil

 redirect "/"
end





