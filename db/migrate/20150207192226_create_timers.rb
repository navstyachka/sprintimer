class CreateTimers < ActiveRecord::Migration
  def change
    create_table :timers do |t|
      t.string :data

      t.timestamps
    end
  end
end
