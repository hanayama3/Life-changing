class RemoveCompleteFromHabits < ActiveRecord::Migration[6.0]
  def change
    remove_column :habits, :complete, :integer
  end
end
