class CreatePlayerPositions < ActiveRecord::Migration
  def change
    create_table :player_positions do |t|
      t.integer :player_id
      t.integer :position_id
    end
  end
end
