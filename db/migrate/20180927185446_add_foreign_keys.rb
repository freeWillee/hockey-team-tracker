class AddForeignKeys < ActiveRecord::Migration
  def change
    add_column :players, :GoalTarget_id, :integer
    add_column :players, :AssistTarget_id, :integer
    add_column :players, :salary_id, :integer
    add_column :players, :position_id, :integer
    add_column :users, :team_id, :integer
  end
end
