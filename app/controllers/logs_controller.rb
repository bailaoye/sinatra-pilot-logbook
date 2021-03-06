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
        erb :'/logs/show'
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
      @log = Log.find(params[:id])
      if current_user.id == @log.user_id
        erb :'/logs/show'
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
      @log = Log.find(params[:id])
      if current_user.id == @log.user_id
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
      @log = Log.find(params[:id])
      @log.update(params[:log])
      @log.save
      erb :'/logs/show'
    end
  end
  
  #delete action
  delete '/logs/:id' do
    @log = Log.find(params[:id])
    if current_user.id == @log.user_id
      @log.delete
      redirect "/users/#{current_user.slug}"
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