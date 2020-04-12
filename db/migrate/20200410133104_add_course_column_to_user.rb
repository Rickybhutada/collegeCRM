class AddCourseColumnToUser < ActiveRecord::Migration
  def up
    add_column :users,:course, :string
  end

  def down
    remove_column :users, :course
  end
end
