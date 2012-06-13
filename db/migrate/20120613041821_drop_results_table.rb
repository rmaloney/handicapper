class DropResultsTable < ActiveRecord::Migration
  def up
  	drop_table :results
  end

  def down
  end
end
