class MessagesController < ApplicationController

  def create
    @message = current_user.messages.build(message_params)
    if @message.save
      flash[:success] = "Message sent."
      redirect_to inbox_messages_path
    else
      render 'static_pages/home'
    end
  end

  def inbox
    @received_messages = Message.find_by(receiver_id: current_user.id).paginate(params[:page])
    @sent_messages = Message.find_by(sender_id: current_user.id).paginate(params[:page])
    @message = Message.find(params[:id])
  end

  def destroy
  end

  private

    def message_params
      params.require(:message).permit(:content, :receiver_id)
    end

end
