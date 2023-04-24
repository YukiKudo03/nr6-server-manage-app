class CurrentReserveEventsController < ApplicationController

  def cancel
    @instrument.current_reserve_event.cancel
    flash[:success] = "Your current resavation was canceled."
    redirect_to root_path
  end

  private
    def reserve_event_params
      params.require(:reserved_events).permit(:instrument_id, :set_time, :input_text)
    end
end
