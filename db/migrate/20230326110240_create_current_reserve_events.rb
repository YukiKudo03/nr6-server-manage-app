class CreateCurrentReserveEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :current_reserve_events do |t|
      t.datetime :reserved_at, null: false
      t.references :instrument, null: false, foreign_key: true, unique: true
      t.integer :execution_type, null: false, default: 0
      t.integer :execution_status, null: false, default: 0
      t.references :reserve_event, null: false, foreign_key: true, unique: true

      t.timestamps
    end
  end
end
