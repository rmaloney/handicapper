class CreateResultsTable < ActiveRecord::Migration
  def up
  	create_table :results do |t|
  		t.integer :game_id
  		t.integer :favorite_score
  		t.integer :underdog_score
  	end
  end

  def down
  end
end
