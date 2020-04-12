class CreateAttendances < ActiveRecord::Migration
  def up
    create_table :attendances do |t|
      t.integer :user_id
      t.datetime :date
      t.timestamps null: false
    end
  end

  def down
    drop_table :attendances
  end
end
