class ChangeDatatypecompleteOfHabits < ActiveRecord::Migration[6.0]
  def change
    change_column :habits, :complete, :integer
  end
end
