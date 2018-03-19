class ConversationsController < ApplicationController
  def index
    redirect_to new_user_session_path if current_user == nil
    @conversations = current_user.r_convs.all + current_user.s_convs.all
  end

  def create
    if params[:sender_id] == current_user.id
      alter_id = params[:receiver_id]
    else
      alter_id = params[:sender_id]
    end
    current_user.conversations.all.each do |conv|
      if alter_id == conv.sender_id || alter_id == conv.receiver_id
        @conversation = conv
        redirect_to conversation_messages_path(@conversation)
      end
    end
    @conversation = Conversation.create(conversation_params)
    redirect_to conversation_messages_path(@conversation)
  end

private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
