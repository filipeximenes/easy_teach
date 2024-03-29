class AddConfirmableToDeviseTeacher < ActiveRecord::Migration
  def change
    change_table(:teachers) do |t| 
      ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable
    end
    add_index :teachers, :confirmation_token,   :unique => true
  end
end
