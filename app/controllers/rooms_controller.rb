class RoomsController < ApplicationController
  
  def show
    @room = Room.find(params[:id])
    if UserRoom.where(user_id: current_user.id, room_id: @room.id).present?
      @chats = @room.chats
      @chat = Chat.new
      @chat_user = @room.user_rooms
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @room = Room.create
    @my_user_room = UserRoom.create(user_id: current_user.id, room_id: @room.id)
    @your_user_room = UserRoom.create(params.require(:user_room).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end
end
