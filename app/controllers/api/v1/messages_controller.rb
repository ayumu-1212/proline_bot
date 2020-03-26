module Api
  module V1
    class MessagesController < ApplicationController
      protect_from_forgery
      def create
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
