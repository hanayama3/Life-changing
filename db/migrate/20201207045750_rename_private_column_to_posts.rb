class RenamePrivateColumnToPosts < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :private, :private_content
  end
end
