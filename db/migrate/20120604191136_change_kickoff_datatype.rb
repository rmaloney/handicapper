class ChangeKickoffDatatype < ActiveRecord::Migration
  def up
  	change_column :games, :kickoff, :string
  end

  def down
  end
end
