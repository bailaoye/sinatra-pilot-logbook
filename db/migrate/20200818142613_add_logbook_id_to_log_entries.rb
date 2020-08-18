class AddLogbookIdToLogEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :log_entries, :logbook_id, :integer
  end
end