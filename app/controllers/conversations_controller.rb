class ConversationsController < ApplicationController
  before_action :authenticate_user!
def index
 @users = User.all
 @conversations = Conversation.all
 @conversations = Conversation.order(updated_at: :desc).page(params[:page])
 end
def create
 if Conversation.between(params[:sender_id],params[:receiver_id])
   .present?
    @conversation = Conversation.between(params[:sender_id],
     params[:receiver_id]).first
 else
  @conversation = Conversation.create!(conversation_params)
 end
 redirect_to conversation_messages_path(@conversation)
end
private
 def conversation_params
  params.permit(:sender_id, :receiver_id)
 end
end



