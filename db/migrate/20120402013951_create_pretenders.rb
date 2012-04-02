class CreatePretenders < ActiveRecord::Migration
  def change
    create_table :pretenders do |t|
      t.string :name

      t.timestamps
    end
  end
end
