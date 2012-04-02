class CreateCouples < ActiveRecord::Migration
  def change
    create_table :couples do |t|
      t.references :pretender_a, null: false
      t.references :pretender_b, null: false
      t.integer :iterations_ago, default: 0, null: false

      t.timestamps
    end
  end
end
