class CreateLogbooks < ActiveRecord::Migration[6.0]
  def change
    create_table :logbooks do |t|
      t.belongs_to :user
      t.string :name
      t.integer :max_entries
    end
  end
end
