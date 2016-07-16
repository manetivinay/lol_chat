class MessagesController < ApplicationController

  def show
    @message = Message.find params[:id]
    if @message.unread? && current_user == @message.recipient
      @message.mark_as_read!
    end
  end

  def sent
    load_user
    @messages = @user.sent_messages
  end

  def received
    load_user
    @messages = @user.received_messages
  end

  def load_user
    if params[:user_id]
      @user = User.find params[:user_id]
    else
      @user = current_user
    end
  end

  def create
    @user = User.find params[:user_id]
    @messages = User.sent_messages.build
  end

  private
  def messages_params
    params.require(:message).permit(:recipient_id, :body)
  end

  def index
    @messages = Message.all

  end

end
