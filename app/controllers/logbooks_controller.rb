class LogbooksController < ApplicationController
  get "/logbooks" do
    @logbooks = Logbook.all
    erb :'logbooks/index'
  end

  get "/logbooks/new" do
    if logged_in?
      erb :'logbooks/new'
    else
      redirect to '/'
    end
  end

  get "/logbooks/:id/edit" do
    if logged_in?
      @logbook = Logbook.find(params[:id])
      erb :'logbooks/edit'
    else
      redirect to '/'
    end
  end

  post "/logbooks/:id" do
    if logged_in?
      @logbook = Logbook.find(params[:id])
    else
      unless Logbook.valid_params?(params)
        redirect to '/logbooks/#{@logbook.id}/edit'
      end
    end
  end

  post "/logbooks" do
    if logged_in?
      unless Logbook.valid_params?(params)
        redirect to '/logbooks/new'
      end
    else
      Logbook.create(params)
      redirect to '/logbooks'
    end
  end
end