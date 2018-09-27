class AddForeignKeys < ActiveRecord::Migration
  def change
    add_column :players, :goalstarget_id, :integer
    add_column :players, :assiststarget_id, :integer
    add_column :players, :salary_id, :integer
    add_column :users, :team_id, :integer
  end
end
