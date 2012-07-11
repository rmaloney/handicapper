class AddUserStandings < ActiveRecord::Migration
  def up
  	create_table :user_standings do |t|
      t.integer  :user_id
      t.integer  :wins
      t.integer    :losses
    end
  end

  def down
  	drop_table :user_standings
  end
end
