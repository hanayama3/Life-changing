class RemoveStartTimeFromHabits < ActiveRecord::Migration[6.0]
  def change
    remove_column :habits, :start_time, :date
  end
end
