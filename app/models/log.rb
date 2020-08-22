class Log < ActiveRecord::Base
  belongs_to :user

  #validate input
  def self.valid_params?(params)
    return !params[:name].empty? && !params[:max_entries].empty?
  end
end