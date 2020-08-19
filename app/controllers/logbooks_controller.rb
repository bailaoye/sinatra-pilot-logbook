class LogbooksController < ApplicationController
  get "/logbooks" do
    if logged_in?
      @logbooks = Logbook.all
      erb :'logbooks/index'
    else
      redirect to '/'
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
    unless Logbook.valid_params?(params)
      redirect to '/logbooks/#{@logbook.id}/edit'
    end
    @logbook.update(params.select{|k|k=='name' || k=='max_entries'})
  end

  post "/logbooks" do
    unless Logbook.valid_params?(params)
      redirect to '/logbooks/new'
    end
    Logbook.create(params)
    redirect to "logbooks"
  end
end