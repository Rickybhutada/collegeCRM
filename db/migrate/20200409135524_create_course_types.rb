class CreateCourseTypes < ActiveRecord::Migration
  def up
    create_table :course_types do |t|
      t.string :name
      t.timestamps null: false
    end
  end

  def down
    drop_table :course_types
  end
end
