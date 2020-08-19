class LogEntriesController < ApplicationController
  get "/log_entries" do
    if logged_in?
      @log_entries = LogEntries.all
      erb :'log_entries/index'
    else
      redirect to '/'
    end
  end

  get "/log_entries/new" do
    if logged_in?
      erb :'log_entries/new'
    else
      redirect to '/'
    end
  end

  get "/log_entries/:id/edit" do
    if logged_in?
      @log_entries = LogEntries.find(params[:id])
      erb :'log_entries/edit'
    else
      redirect to '/'
    end
  end

  post "/log_entries/:id" do
    @entry = LogEntry.find(params[:id])
    unless LogEntry.valid_params?(params)
      redirect to '/log_entries/#{@entry.id}/edit'
    end
    @entry.update(params.select{|k|k=='date' || k=='pilot_in_command' || k=='aircraft_type' || k=='aircraft_rego' || k=='origin' || k=='destination' || k=='landings' || k=='remarks'})
    redirect to '/log_entries/#{@entry.id}'
  end

  post "/log_entries" do
    unless LogEntries.valid_params?(params)
      redirect to '/log_entries/new'
    end
    LogEntries.create(params)
    redirect to "/log_entries"
  end
end

end