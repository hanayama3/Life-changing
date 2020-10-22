class CreateHabits < ActiveRecord::Migration[6.0]
  def change
    create_table :habits do |t|
      t.string :task
      t.integer :frequency
      t.integer :user_id

      t.timestamps
    end
  end
end
