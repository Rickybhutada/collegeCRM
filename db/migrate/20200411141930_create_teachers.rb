class CreateTeachers < ActiveRecord::Migration
  def up
    create_table :teachers do |t|
      t.integer :user_id
      t.integer :course_type_id
      t.integer :course_id
      t.integer :subject_id
      t.datetime :start_datetime

      t.timestamps null: false
    end
  end

  def down
    drop_table :teachers
  end
end
