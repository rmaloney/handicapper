class RenameResultInPlay < ActiveRecord::Migration
  def up
  	rename_column :plays, :result, :play_result
  end

  def down
  end
end
