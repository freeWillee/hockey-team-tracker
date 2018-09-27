class CreateForeignkeys < ActiveRecord::Migration
  def change
    add_column :players, :team_id, :integer
    add_column :players, :target_id, :integer
  end
end
