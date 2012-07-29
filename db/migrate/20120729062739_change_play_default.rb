class ChangePlayDefault < ActiveRecord::Migration
  def up
  	change_column_default :plays, :status, "Open"
  end

  def down
  end
end
