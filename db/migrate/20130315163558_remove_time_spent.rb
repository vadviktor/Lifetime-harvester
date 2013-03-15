class RemoveTimeSpent < ActiveRecord::Migration
  def change
    remove_column :tasks, :time_spent
  end
end
