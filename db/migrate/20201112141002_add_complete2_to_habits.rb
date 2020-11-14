class AddComplete2ToHabits < ActiveRecord::Migration[6.0]
  def change
    add_column :habits, :complete, :integer, default: 0, null: false
  end
end
