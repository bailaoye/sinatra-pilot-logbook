class LogEntriesController < ApplicationController
  get "/log_entries" do
    if !logged_in?
      erb :'/redirects/notauthorized'
    else
      @log_entries = LogEntry.all
      erb :'log_entries/index'
    end
  end

  get "/log_entries/new" do
    if !logged_in?
      erb :'/redirects/notauthorized'
    else
      erb :'log_entries/new'
    end
  end

  get '/log_entries/:id' do
    if !logged_in?
      redirect '/login'
    else
      @log_entry = LogEntry.find_by_id(params[:id])
      erb :'/log_entries/show'
    end
  end

  get "/log_entries/:id/edit" do
    if !logged_in?
      erb :'/redirects/notauthorized'
    else
      @log_entry = LogEntry.find(params[:id])
      erb :'log_entries/edit'
    end
  end

  post "/log_entries/:id" do
    @log_entry = LogEntry.find(params[:id])
    unless LogEntry.valid_params?(params)
      redirect to '/log_entries/#{@entry.id}/edit'
    end
    @log_entry.update(params.select{|k|k=='date' || k=='pilot_in_command' || k=='aircraft_type' || k=='aircraft_rego' || k=='origin' || k=='destination' || k=='landings' || k=='remarks'})
    redirect to '/log_entries/#{@entry.id}'
  end

  post "/log_entries" do
    unless LogEntry.valid_params?(params)
      redirect to '/log_entries/new'
    end
    LogEntry.create(params)
    redirect to "/log_entries"
  end
end