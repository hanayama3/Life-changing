class ChangeDatatypecompleteOfHabits < ActiveRecord::Migration[6.0]
  def up
    change_column :habits, :complete, :integer
  end
end
