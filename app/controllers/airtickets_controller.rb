class AirticketsController < ApplicationController

  def show
  end

  def new
  end

  def edit
  end

  def index
    def index
      @tickes = Airticket.find(:all)

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @tickets }
      end
    end
  end
end
