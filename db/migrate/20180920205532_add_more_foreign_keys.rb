class AddMoreForeignKeys < ActiveRecord::Migration
  def change
    add_column :players, :salary_id, :integer
    add_column :staffs, :salary_id, :integer
  end
end
