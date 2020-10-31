class AddCompleteToHabits < ActiveRecord::Migration[6.0]
  def change
    add_column :habits, :complete, :boolean, default: false, null: false
  end
end
