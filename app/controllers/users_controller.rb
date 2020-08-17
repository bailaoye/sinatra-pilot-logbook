class UsersController < ApplicationController 

  get '/users/:id' do
    #redirect if not logged in
    if !logged_in?
      redirect '/logbooks'
    end
    #if user credentials valid, show user page
    @user = User.find(params[:id])
    if !@user.nil? && @user == current_user
      erb :'users/show'
    else
      redirect '/logbooks'
    end
  end

  get '/signup' do
    if !session[:user_id]
      erb :'users/new'
    else
      redirect to '/logbooks'
    end
  end

  post '/signup' do 
    if params[:username] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
      redirect '/logbooks'
    end
  end

  get '/login' do 
    @error_message = params[:error]
    if !session[:user_id]
      erb :'users/login'
    else
      redirect '/logbooks'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/logbooks"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if session[:user_id] != nil
      session.destroy
      redirect to '/login'
    else
      redirect to '/'
    end
  end

end