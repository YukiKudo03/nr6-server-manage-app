class Instrument < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reserve_events
  has_one :current_reserve_event
  validates :serial, presence: true, uniqueness: true

  def set_current_reserve_event(reserve_event)
    if current_reserve_event.present?
      current_reserve_event.delete
    end
    current_reserve_event = CurrentReserveEvent.create({
      reserved_at: reserve_event.set_time,
      execution_type: reserve_event.execution_type,
      instrument_id: id,
      reserve_event_id: reserve_event.id
    })
  end
end
