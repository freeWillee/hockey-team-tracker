class CreateForeignkeys < ActiveRecord::Migration
  def change
    add_column :players, :team_id, :integer
    add_column :staffs, :team_id, :integer
  end
end
