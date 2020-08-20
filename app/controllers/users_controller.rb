class UsersController < ApplicationController 

  get '/users/:id' do
    #redirect if not logged in
    if !logged_in?
      redirect '/login'
    end
    #if user credentials valid, show user page
    @user = User.find(params[:id])
    if !@user.nil? && @user == current_user
      erb :'users/show'
    else
      redirect '/'
    end
  end

  get '/signup' do
    if !logged_in?
      erb :'users/signup'
    else
      @user = current_user
      erb :'users/show'
    end
  end

  post '/signup' do 
    if params[:username] == "" || params[:password] == ""
      redirect to '/users/signup'
    else
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
      erb :'users/show'
    end
  end

  get '/login' do 
    if !logged_in?
      erb :'users/login'
    else
      erb :'users/show'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      erb :'users/show'
    else
      erb :'redirects/failure'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      erb :'redirects/loggedout'
    else
      redirect to '/'
    end
  end

end