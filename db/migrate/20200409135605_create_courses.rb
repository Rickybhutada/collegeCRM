class CreateCourses < ActiveRecord::Migration
  def up
    create_table :courses do |t|
      t.string :name
      t.references :course_type, index: true, foreign_key: true
      t.timestamps null: false
    end
  end

  def down
    drop_table :courses
  end
end
