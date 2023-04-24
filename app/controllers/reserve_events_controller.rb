class ReserveEventsController < ApplicationController
  before_action :set_reserve_event, only: [:show, :edit, :update, :destroy]

  def index
    @reserve_events = @instrument.reserve_events
  end

  def show
  end

  def new
    @reserve_event = ReserveEvent.new
  end

  def get_koume_tweet
    koume_tweet = KoumeTweetWorker.get_koume_tweet
    respond_to do |format|
      format.json {render json: koume_tweet}
    end
  end
  
  def create
    unless reserve_event_params[:set_time].present?
      flash[:danger] = "設定時間エラー"
      redirect_to new_reserve_event_path(instrument_id: @instrument.id) and return 
    end
    unless DateTime.parse(reserve_event_params[:set_time]) > DateTime.now
      flash[:danger] = "設定時間は現在よりも遅い時間を設定してください"
      redirect_to new_reserve_event_path(instrument_id: @instrument.id) and return 
    end
    unless reserve_event_params[:input_text].present?
      redirect_to new_reserve_event_path(instrument_id: @instrument.id) and return
    end
    @reserve_event = @instrument.reserve_events.build(
      {
        set_time: reserve_event_params[:set_time],
        input_text: reserve_event_params[:input_text]
      }
    )
    PostToChatGptWorker.new(@reserve_event, @client)\
    .post_to_chat_gpt
    puts "#{@reserve_event.execution_type}, #{@reserve_event.output_text}"
    if @reserve_event.valid?(:create)
      @reserve_event.save(context: :create)
      @instrument.set_current_reserve_event(@reserve_event)
      redirect_to reserve_event_path(id: @reserve_event.id, instrument_id: @instrument.id)
    else
      flash[:danger] = @reserve_event.errors.full_messages
      render 'new'
    end
  end

  private
    def set_reserve_event
      @reserve_event = @instrument.reserve_events.find(params[:id]) 
    end

    def reserve_event_params
      params.require(:reserve_event).permit(:set_time, :completed_at, :declined_at, :input_text)
    end
end
