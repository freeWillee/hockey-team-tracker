class Targets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
      t.integer :goals
      t.integer :assists
    end
  end
end
