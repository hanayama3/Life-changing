class AddComplete2ToHabits < ActiveRecord::Migration[6.0]
  def change
    add_column :habits, :complete, :integer
  end
end
