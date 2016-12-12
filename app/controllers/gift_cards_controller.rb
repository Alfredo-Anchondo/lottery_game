class GiftCardsController < ApplicationController
  before_action :set_gift_card, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @gift_cards = GiftCard.all
    respond_with(@gift_cards)
  end

  def show
    respond_with(@gift_card)
  end

  def new
    @gift_card = GiftCard.new
    respond_with(@gift_card)
  end

  def edit
  end

  def create
    @gift_card = GiftCard.new(gift_card_params)
    @gift_card.save
    respond_with(@gift_card)
  end

  def update
    @gift_card.update(gift_card_params)
    respond_with(@gift_card)
  end

  def destroy
    @gift_card.destroy
    respond_with(@gift_card)
  end

  private
    def set_gift_card
      @gift_card = GiftCard.find(params[:id])
    end

    def gift_card_params
      params.require(:gift_card).permit(:value, :user_id, :code, :available)
    end
end
