class CreateIndices < ActiveRecord::Migration
  def change
    create_table :indices do |t|
      t.string :slug
      t.integer :indexable_id
      t.string :indexable_type

      t.timestamps
    end
  end
end
