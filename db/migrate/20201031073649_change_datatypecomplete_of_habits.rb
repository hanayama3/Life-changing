class ChangeDatatypecompleteOfHabits < ActiveRecord::Migration[6.0]
  def up
    change_column :habits, :complete, :integer, using: 'complete::integer'
  end
  
  def down
    change_column :habits, :complete, :boolean, default: false, null: false
  end
end