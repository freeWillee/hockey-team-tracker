class CreateStaff < ActiveRecord::Migration
  def change
    create_table :staff do |t|
      t.string :name
      t.string :role
    end
  end
end
