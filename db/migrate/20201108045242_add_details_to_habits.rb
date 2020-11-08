class AddDetailsToHabits < ActiveRecord::Migration[6.0]
  def change
    add_column :habits, :start_time, :date
    add_column :habits, :end_time, :date
  end
end
