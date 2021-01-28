class Log < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :date, :pilot_in_command
end