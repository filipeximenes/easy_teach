class AddIndexToIndexSlug < ActiveRecord::Migration
  def change
    add_index :indices, :slug, unique: true
  end
end
