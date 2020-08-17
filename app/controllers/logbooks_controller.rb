class LogbooksController < ApplicationController
  get "/logbooks" do
    @logbooks = Logbook.all
    erb :'logbooks/index'
  end

  get "/logbooks/new" do
    if User.logged_in?
      erb :'logbooks/new'
    else
      redirect to '/'
    end
  end

end