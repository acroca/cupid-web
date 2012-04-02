class PretenderBIsNotMandatory < ActiveRecord::Migration
  def up
    change_column_null :couples, :pretender_b_id, true
  end

  def down
    change_column_null :couples, :pretender_b_id, false
  end
end
