class MessagesController < ApplicationController
  after_filter :message_read, only: :show
  # before_filter :check_recipient

  def check_recipient

    if session[:user_id] != current_user
      redirect_to root_path
    end
  end

  def index
    @messages = Message.all
  end

  def inbox
    @received_messages = Message.where(recipient_id: current_user.id).order('created_at DESC').limit(5)
  end

  def sent_messages
    @sent_messages = Message.where(sender_id: current_user.id).order('read_at DESC').limit(5)
  end

  def show
    @message = Message.find params[:id]
    if @message.recipient_id == current_user.id
      if @message.read_at.nil?
        @message.update_columns(read_at: Time.now)
      end
    end
    unless @message.recipient_id == current_user.id
      flash[:error] = "You are not authorized to view this message !!!"
      redirect_to root_path
    end
  end

  def message_read
    if !@message.read.present? && current_user == @message.recipient
      @message.update_columns(read: true)
    end
  end

  def new
    @user = current_user
    @message = Message.new
  end

  def create
    # @user = User.find params[:user_id]
    @message = Message.new(messages_params)
    @message.sender_id = current_user.id
    # @messages = User.sent_messages.build
    if @message.save
      flash[:success] = 'Message sent successfully'
      redirect_to sent_messages_path
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

  private
  def messages_params
    params.require(:message).permit(:body, :recipient_id)
  end


end
