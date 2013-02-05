class CreateInvitedTeachers < ActiveRecord::Migration
  def change
    create_table :invited_teachers do |t|
      t.integer :teacher_id
      t.string :email

      t.timestamps
    end
  end
end
