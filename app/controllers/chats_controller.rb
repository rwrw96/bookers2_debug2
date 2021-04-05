class ChatsController < ApplicationController
  def create
    if UserRoom.where(user_id: current_user.id).present?
      @chat = Chat.create(params.require(:chat).permit(:user_id, :room_id, :content).merge(user_id: current_user.id))
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
      redirect_to room_path(@chat.room_id)
    end
  end
end
