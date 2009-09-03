class TicketsController < ApplicationController

  def index
    @tickets = AirticketItem.find(:all)
  end
end
