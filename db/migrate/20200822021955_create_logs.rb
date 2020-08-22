class CreateLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :logs do |t|
      t.belongs_to :user
      t.date :date
      t.string :pilot_in_command
      t.string :aircraft_type
      t.string :aircraft_rego
      t.string :origin
      t.string :destination
      t.integer :landings
      t.string :remarks
    end
  end
end
