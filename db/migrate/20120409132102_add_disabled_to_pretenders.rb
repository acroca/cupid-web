class AddDisabledToPretenders < ActiveRecord::Migration
  def change
    add_column :pretenders, :disabled, :boolean, default: false, null: false
  end
end
