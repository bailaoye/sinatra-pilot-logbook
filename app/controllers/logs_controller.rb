class LogsController < ApplicationController
  #new action
  get '/logs/new' do
    if !logged_in?
      erb :'/redirects/notauthorized'
    else
      erb :'/logs/new'
    end
  end

  post '/logs' do
    if !logged_in?
      erb :'/redirects/notauthorized'
    else
      @log = current_user.logs.new(params[:log])
      if @log.save
        redirect "/logs/#{@log.id}"
      else
        redirect '/logs/new'
      end
    end
  end

  #show action
  get '/logs/:id' do
    if !logged_in?
      erb :'/redirects/notauthorized'
    else
      @log = Log.find_by_id(params[:id])
      @user = current_user
      if @user.id == @log.user_id
        redirect "/logs/#{@log.id}"
      else
        erb :'/redirects/notauthorized'
      end
    end
  end

  #edit action
  get '/logs/:id/edit' do
    if !logged_in?
      erb :'/redirects/notauthorized'
    else
      @log = Log.find_by_id(params[:id])
      @user = current_user
      if @user.id == @log.user_id
        erb :'/logs/edit'
      else
        erb :'/redirects/notauthorized'
      end
    end
  end

  patch '/logs/:id' do
    if !logged_in?
      erb :'/redirects/notauthorized'
    else
      @log = Log.find_by_id(params[:id])
      @log.update(params[:log])
      @log.save
      redirect "/logs/#{@log.id}"
    end
  end
  
  #delete action
  delete '/logs/:id' do
    @log = Log.find_by_id(params[:id])
    @user = current_user
    if @user.id == @log.user_id
      @log.delete
      redirect "/users/#{@user.id}"
    else
      erb :'/redirects/notauthorized'
    end
  end

  #show all landings with :number on a page
  get '/landings/:number' do
    @logs = Log.where(landings: params[:number])
    erb :'/landings'
  end
  
end