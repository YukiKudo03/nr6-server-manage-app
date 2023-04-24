class CreateReserveEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :reserve_events do |t|
      t.references :instrument, null: false, foreign_key: true
      t.datetime :set_time, null: false
      t.datetime :completed_at
      t.datetime :declined_at
      t.text :input_text, null: false
      t.text :output_text, null: false
      t.integer :execution_type, null: false, default: 0
      t.integer :reserve_events_count, null: false, default: 0
      
      t.timestamps
    end
  end
end
