class CurrentReserveEvent < ApplicationRecord
  belongs_to :instrument
  belongs_to :reserve_event
  enum execution_type: {
    gentle: 0,
    mild: 1,
    normal: 2,
    wild:3,
    awsome: 4,
  }
  enum execution_status: {
    before_checked: 0,
    checked: 1,
    executing: 2,
    executed: 3,
    removed: 4,
    declined: 5   
  }

  def complete
    reserve_event.assign_attributes({
      completed_at: DateTime.now
    })
    reserve_event.save(context: :complete)
    self.delete
  end

  def cancel
    reserve_event.assign_attributes({
      declined_at: DateTime.now
    })
    reserve_event.save(context: :cancel)
    self.delete
  end
end
