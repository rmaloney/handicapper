class AddStartTimeToGame < ActiveRecord::Migration
  def change
    add_column :games, :start_time, :datetime

  end
end
