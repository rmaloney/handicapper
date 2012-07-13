class DeleteUserStandings < ActiveRecord::Migration
  def up
  	drop_table :user_standings
  end

  def down
  	
  end
end
