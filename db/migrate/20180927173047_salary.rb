class Salary < ActiveRecord::Migration
  def change
    create_table :salary do |t|
      t.integer :salary
    end
  end
end
