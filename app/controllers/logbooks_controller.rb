class LogbooksController < Sinatra::Base
  get "/logbooks" do
    redirect_if_not_logged_in
    @logbooks = Logbook.all
    erb :'logbooks/index'
  end

  get "/logbooks/new" do
    redirect_if_not_logged_in
    @error = params[:error]
  end

end