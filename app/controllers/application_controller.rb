require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "ilovelogbooks"
  end

  get '/' do
    erb :index
  end

  not_found do
    status 404
    erb :notfound
  end

  helpers do
    def not_logged_in
      if !logged_in?
        redirect to "/login?error=Please log in to complete action"
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end 