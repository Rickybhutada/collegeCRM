class CreateUserRoles < ActiveRecord::Migration
  def up
    create_table :user_roles do |t|
      t.references :user, foreign_key: true, index: true
      t.integer :role_id, null: false
      t.timestamps null: false
    end
  end

  def down
    drop_table :user_roles
  end
end
