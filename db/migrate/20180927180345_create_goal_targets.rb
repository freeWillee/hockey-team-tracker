class CreateGoalTargets < ActiveRecord::Migration
  def change
    create_table :goal_targets do |t|
      t.integer :target
    end
  end
end
