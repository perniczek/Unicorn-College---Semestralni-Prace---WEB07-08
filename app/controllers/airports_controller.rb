class AirportsController < ApplicationController
  include AirportsHelper
  
  # GET /airport
  # GET /airport.xml
  def index
    @airports = Airport.find(:all)    
    
    respond_to do |format|
      format.html  # index.html.erb
      format.xml  { render :xml => @airports }
    end
  end

  # GET /airport/1
  # GET /airport/1.xml
  def show
    @airport = Airport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @airport }
    end
  end

  # GET /airport/new
  # GET /airport/new.xml
  def code_changed
    @found_airport = Airport.find_by_code(params[:airport][:code])
    respond_to {|format| format.js}
  end
  def new
    @airport = Airport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @airport }
    end
  end

  # GET /airport/1/edit
  def edit
    @airport = Airport.find(params[:id])
  end

  # POST /airport
  # POST /airport.xml
  def create
    gps_position_decode(:airport,:gps_position)
    @airport = Airport.new(params[:airport])

    respond_to do |format|
      if @airport.save
        flash[:notice] = 'Airport was successfully created.'
        format.html { redirect_to(@airport) }
        format.xml  { render :xml => @airport, :status => :created, :location => @airport }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @airport.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /airport/1
  # PUT /airport/1.xml
  def update
    gps_position_decode(:airport,:gps_position)
    @airport = Airport.find(params[:id])

    respond_to do |format|
      if @airport.update_attributes(params[:airport])
        flash[:notice] = 'Airport was successfully updated.'
        format.html { redirect_to(@airport) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @airport.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /airport/1
  # DELETE /airport/1.xml
  def destroy
    @airport = Airport.find(params[:id])
    @airport.destroy

    respond_to do |format|
      format.html { redirect_to(airports_url) }
      format.xml  { head :ok }
    end
  end
end
