class LogsController < ApplicationController
  get '/logs' do
    if !logged_in?
      erb :'/redirects/notauthorized'
    else
      @user = current_user
      @logs = Log.all.select {|log| log.user_id = @user.id}
      erb :'/logs/index'
    end
  end

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
      @log = current_user.logs.new(date: params[:date], pilot_in_command: params[:pilot_in_command], aircraft_type: params[:aircraft_type], aircraft_rego: params[:aircraft_rego], origin: params[:origin], destination: params[:destination], landings: params[:landings], remarks: params[:remarks])
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
      @user = current_user
      @log = Log.find_by_id(params[:id])
      @log.name = params[:name]
      @log.max_entries = params[:max_entries]
      @log.save
      redirect "/logs/#{@log.id}"
    end
  end

  delete '/logs/:id' do
    @log = Log.find_by_id(params[:id])
    @user = current_user
    if @user.id == @log.user_id
      @log.delete
      redirect '/users/show'
    else
      erb :'/redirects/notauthorized'
    end
  end
end