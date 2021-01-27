class LogsController < ApplicationController
  get '/logs/new' do
    if !logged_in?
      erb :'/redirects/notauthorized'
    else
      @user = current_user
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

  get '/logs/:id' do
    if !logged_in?
      erb :'/redirects/notauthorized'
    else
      @log = Log.find_by_id(params[:id])
      @user = current_user
      if @user.id == @log.user_id
        erb :'/logs/show'
      else
        erb :'/redirects/notauthorized'
      end
    end
  end

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

  delete '/logs/:id' do
    @log = Log.find_by_id(params[:id])
    @user = current_user
    if @user.id == @log.user_id
      @log.delete
      erb :'/users/show'
    else
      erb :'/redirects/notauthorized'
    end
  end

  get '/landings/:number' do
    @logs = Log.where(landings: params[:number])
    erb :'/landings'
  end
end