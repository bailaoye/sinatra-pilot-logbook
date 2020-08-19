class LogbooksController < ApplicationController
  get '/logbooks' do
    if !logged_in?
      redirect '/login'
    else
      @user = current_user
      @logbooks = Logbook.all.select {|logbook| logbook.user_id = @user.id}
      erb :'/logbooks/index'
    end
  end

  get '/logbooks/new' do
    if !logged_in?
      redirect '/login'
    else
      @logbooks = Logbook.all
      erb :'/logbooks/new'
    end
  end

  post '/logbooks' do
    if !logged_in?
      redirect '/login'
    else
      @user = current_user
      if Logbook.valid_params?(params)
        Logbook.create(params)
      else
        redirect '/logbooks/new'
      end
    end
  end

  get '/logbooks/:id' do
    if !logged_in?
      redirect '/login'
    else
      @logbook = Logbook.find_by_id(params[:id])
      erb :'logbooks/show'
    end
  end

  get '/logbooks/:id/edit' do
    if !logged_in?
      redirect '/login'
    else
      @logbook = Logbook.find_by_id(params[:id])
      if @logbook == nil
        redirect 'users/show'
      elsif authorized?(@logbook)
        erb :'/logbooks/edit'
      else
        redirect '/logout'
      end
    end
  end

  patch '/logbooks/:id' do
    if !logged_in?
      redirect '/login'
    else
      @user = current_user
      @logbook = Logbook.find_by_id(params[:id])
      @logbook.name = params[:name]
      @logbook.max_entries = params[:max_entries]
      @logbook.save
      redirect '/logbooks/#{@logbook.id}'
    end
  end

  delete '/logbooks/:id' do
    @logbook = Logbook.find_by_id(params[:id])
    @user = current_user
    if @user.id == @logbook.user_id
      @logbook.delete
      redirect '/users/show'
    else
      redirect '/logout'
    end
  end
end
