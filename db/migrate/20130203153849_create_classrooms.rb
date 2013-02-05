class CreateClassrooms < ActiveRecord::Migration
  def change
    create_table :classrooms do |t|
      t.integer :index_id
      t.string :name
      t.string :slug

      t.timestamps
    end
    add_index :classrooms, [:index_id, :slug], :unique => true
  end
end
