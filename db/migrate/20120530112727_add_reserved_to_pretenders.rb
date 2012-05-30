class AddReservedToPretenders < ActiveRecord::Migration
  def change
    add_column :pretenders, :reserved, :boolean, default: false
  end
end
