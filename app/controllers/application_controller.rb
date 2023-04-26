class ApplicationController < ActionController::Base
    require "openai"
    require 'dotenv'
    Dotenv.load
    before_action :set_common_variable

    private

    # APIキーを設定
    def set_common_variable
        @instrument = Instrument.find(1)
        @client = OpenAI::Client.new(access_token: Rails.application.credentials.dig(:chat_gpt, :chat_gpt_api_key))
    end
end
