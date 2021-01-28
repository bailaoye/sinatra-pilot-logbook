class UsersController < ApplicationController 
  #signup (new) action
  get '/signup' do
    if !logged_in?
      erb :'/users/signup'
    else
      redirect "/users/#{current_user.slug}"
    end
  end

  post '/signup' do 
    if params[:username] == "" || params[:password] == ""
      redirect '/users/signup'
    else
      @user = User.create(params[:user])
      session[:user_id] = @user.id
      redirect "/users/#{current_user.slug}"
    end
  end

  #show action
  get '/users/:slug' do
    #redirect if not logged in
    if !logged_in?
      redirect '/login'
    end
    #if user credentials valid, show user page
    @user = User.find_by_slug(params[:slug])
    if !@user.nil? && @user == current_user
      redirect "/users/#{current_user.slug}"
    else
      erb :'/redirects/notauthorized'
    end
  end

  #login action
  get '/login' do 
    if !logged_in?
      erb :'/users/login'
    else
      redirect "/users/#{current_user.slug}"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/users/#{current_user.slug}"
    else
      erb :'/redirects/failure'
    end
  end

  #logout (delete) action
  get '/logout' do
    if session[:user_id]
      session.destroy
      erb :'/redirects/loggedout'
    else
      redirect '/'
    end
  end

end