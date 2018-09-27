class CreateAssistTargets < ActiveRecord::Migration
  def change
    create_table :assist_targets do |t|
      t.integer :target
    end
  end
end
