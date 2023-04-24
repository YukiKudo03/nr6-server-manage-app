class ReserveEvent < ApplicationRecord
  belongs_to :instrument
  has_one :current_reserve_event
  validates :set_time, presence: true
  validate :set_time_must_be_greater_than_now, on: :create
  enum execution_type: {
    gentle: 0,
    mild: 1,
    normal: 2,
    wild:3,
    awsome: 4,
  }

  private
    def set_time_must_be_greater_than_now
      if set_time.blank? || set_time <= DateTime.now
        errors.add(:set_time, "set_time must be greater than now.")
      end
    end

end
