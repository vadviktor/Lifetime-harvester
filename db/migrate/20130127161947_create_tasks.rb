class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.integer :time_spent
      t.timestamp :started
      t.timestamp :finished

      t.timestamps
    end
  end
end