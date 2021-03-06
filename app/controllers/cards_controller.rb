class CardsController < ApplicationController
  before_action :set_user, :set_room

  def create
    return if @room.end?

    card = @room.cards.find_by(user: @user)
    if card.present?
      card.update(card_params)
    else
      card = @room.cards.create(card_params.merge(user: @user))
    end
    @user.update(last_room: @room.id)
    render partial: 'rooms/hand', locals: { room: @room, card: card }
  end

  private

  def card_params
    params.require(:card).permit(:point)
  end

  def set_room
    @room = Room.find_by(base: params[:room_base])
  end
end
