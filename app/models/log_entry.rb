class LogEntry < ActiveRecord::Base
  belongs_to :logbook

  #validate input
  def self.valid_params?(params)
    return !params[:date].empty? && !params[:pilot_in_command].empty? && !params[:aircraft_type].empty? && !params[:aircraft_rego].empty? && !params[:origin].empty? && !params[:destination].empty? && !params[:landings].empty?
  end
end