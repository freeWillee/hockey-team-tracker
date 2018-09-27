class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.string :birth_year
      t.integer :goals
      t.integer :assists
    end
  end
end
