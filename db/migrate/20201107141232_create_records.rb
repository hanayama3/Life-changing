class CreateRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :records do |t|
      t.integer :level
      t.date :date
      t.integer :user_id

      t.timestamps
    end
  end
end
