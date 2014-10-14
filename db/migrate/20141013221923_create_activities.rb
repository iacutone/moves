class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.datetime :day
      t.string :group
      t.integer :duration
      t.integer :distance
      t.integer :steps
      t.integer :calories

      t.timestamps
    end
  end
end
