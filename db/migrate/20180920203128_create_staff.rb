class CreateStaff < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :name
      t.string :role
    end
  end
end
