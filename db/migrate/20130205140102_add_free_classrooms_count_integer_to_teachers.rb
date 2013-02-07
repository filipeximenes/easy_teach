class AddFreeClassroomsCountIntegerToTeachers < ActiveRecord::Migration
  def change
    change_table(:teachers) do |t| 
      t.integer   :free_class_counter, :default => 1
      t.integer   :referral_count, :default => 0
    end
  end
end
