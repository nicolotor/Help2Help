class ChatsController < ApplicationController
  def show
    @chat = Chat.find(params[:id])
    @message = Message.new
    authorize @chat
  end
  def create
    @chat = Chat.new
    authorize @chat
    profile = Profile.find(params[:profile_id])
    if @chat.save
      UserChat.create(chat: @chat, user: current_user)
      UserChat.create(chat: @chat, user: profile.user)
      redirect_to chat_path(@chat)
    else
      render 'profiles/show'
    end
  end

  private
  def chat_params
    params.require(:chat).permit(:name)
  end
end
