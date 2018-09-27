class AddForeignKeys < ActiveRecord::Migration
  def change
    add_column :players, :goal_target_id, :integer
    add_column :players, :assist_target_id, :integer
    add_column :players, :salary_id, :integer
    add_column :players, :position_id, :integer
    add_column :users, :team_id, :integer
  end
end
