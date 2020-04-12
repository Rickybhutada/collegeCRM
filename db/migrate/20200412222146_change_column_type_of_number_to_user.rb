class ChangeColumnTypeOfNumberToUser < ActiveRecord::Migration
  def up
    change_column :users, :number,:string
  end

  def down
    remove_column :users, :number,:integer
  end
end
