class CreateSalaries < ActiveRecord::Migration
  def change
    create_table :salaries do |t|
      t.string :range
    end
  end
end
