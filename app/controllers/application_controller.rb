require './config/environment'
require './app/models/user'
require './app/models/logbook'
require './app/models/log_entry'


class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
    erb :index
  end

  not_found do
    status 404
    erb :'redirects/notfound'
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end      

    def authorized?(logbook)
      current_user.id == logbook.user_id
    end
  end
end 