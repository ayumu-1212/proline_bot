module Api
  module V1
    class MessagesController < ApplicationController
      protect_from_forgery
      def create
        message = {
          type: 'text',
          text: '朝になりました。本日も頑張りましょう。食べた食べ物を「ひらがな」で入力すると、食品のカロリーと本日のトータルカロリーが表示されます。入力ミスの場合、「みす」と入力すると最新の入力を消去できます。カロリー計算に使ってください。'
        }
        client = Line::Bot::Client.new { |config|
          config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
          config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
        }
        response = client.push_message("<to>", message)
        p response

        message = Message.new(message_params)

        if message.save
          render json: { status: 'SUCCESS', message: 'Saved message.', data: message }, status: :ok
        else
          render json: { status: 'ERROR', message: 'Message not saved.', data: message.errors }, status: :unprocessable_entity
        end


      end

      private
      def message_params
        params.permit(:content)
      end
    end
  end
end
