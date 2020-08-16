require './config/environment'

class LogbooksController < Sinatra::Base
  get "/logbooks" do
    not_logged_in
    @logbooks = Logbook.all
    erb :'logbooks/index'
  end

  get "/logbooks/new" do
    not_logged_in
    @error = params[:error]
  end

end