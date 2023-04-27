class Api::V1::PaulingController < ApiController
    before_action :set_instrument

    def check_resevation_condition
        if @instrument.current_reserve_event.present?
            if @instrument.current_reserve_event.executing?
                return render :json => {reservation_exists: false}
            end
            retJsonText = { 
                instrument: @instrument.serial, 
                mode: @instrument.current_reserve_event.execution_type,
                set_time: @instrument.current_reserve_event.set_time.iso8601,
                reservation_exists: true
            }
            @instrument.current_reserve_event.checked!
            return render :json => retJsonText
        else
            return render :json => {reservation_exists: false}
        end
    end

    def begin_execution
        @instrument.current_reserve_event.executing!
    end

    def complete_resevation
        if @instrument.current_reserve_event.present?
            @instrument.current_reserve_event.complete
            return render :json => {completed: true}
        else
            return render :json => {reservation_exists: false}
        end
    end

    private

    def check_condition_params
        params.permit(:instrument_serial)
    end

    def set_instrument
        @instrument = Instrument.find_by(serial: check_condition_params[:instrument_serial])
    end
end
