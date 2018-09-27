class CreateSalaryTable < ActiveRecord::Migration
  def change
    create_table :salaries do |t|
      t.integer :amount
    end
  end
end
