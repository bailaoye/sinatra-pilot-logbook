class AddUserIdToLogbooks < ActiveRecord::Migration[6.0]
  def change
    add_column :logbooks, :user_id, :integer
  end
end
