class ChatsController < ApplicationController
  before_action :require_login
  def index
    chats = current_user.chats
    @existing_chats_users = current_user.existing_chats_users
  end


  
  def create
    @other_user = User.find(params[:other_user])
    @chat = find_chat(@other_user) || Chat.new(identifier: SecureRandom.hex)
    if !@chat.persisted?
      @chat.save
      @chat.subscriptions.create(user_id: current_user.id)
      @chat.subscriptions.create(user_id: @other_user.id)
    end
    redirect_to chats_path(current_user, @chat,  :other_user => @other_user.id) 
  end




  def show
    @other_user = User.find(params[:other_user])
    current_user.subscriptions.each do |sub|
        sub.chat.subscriptions.each do |sub2|
            if sub != sub2
                if @other_user == sub2.user
                    @chat = sub.chat
                end
            end
        end
    end
    if @chat == nil
        @other_user.chats << a = Chat.create
        current_user.chats << a
        a.save
        @chat = a
    end
    @message = Message.new
  end



private

  def find_chat(second_user)
    chats = current_user.chats
    chats.each do |chat|
      chat.subscriptions.each do |s|
        if s.user_id == second_user.id
          return chat
        end
      end
    end
  end

  def require_login
    redirect_to new_session_path unless user_signed_in?
  end

end