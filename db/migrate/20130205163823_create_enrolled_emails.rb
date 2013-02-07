class CreateEnrolledEmails < ActiveRecord::Migration
  def change
    create_table :enrolled_emails do |t|
      t.integer :classroom_id
      t.string :email
      t.string :name
      t.boolean :confirmed, default: false

      t.timestamps
    end
    add_index :enrolled_emails, [:classroom_id, :email], :unique => true
  end
end
