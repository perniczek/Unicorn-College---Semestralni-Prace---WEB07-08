class FlightsController < ApplicationController
  
  def save_people
    @flight.flight_crews.destroy_all
    if params[:captain]
      @captain = FlightCrew.new
      @captain.flight = @flight
      @captain.crew = Crew.find(params[:captain])
      @captain.role = 'captain'
      @captain.save
    end
    if params[:copilot]  
      @copilot = []
      params[:copilot].each do |cop|
        copilot = FlightCrew.new
        copilot.flight = @flight
        copilot.crew = Crew.find(cop)
        copilot.role = 'copilot'
        copilot.save
        @copilot << copilot
        @flight.flight_crews << copilot
      end
    end
    if params[:cabin_crews]
      @cabin_crews = []
      params[:cabin_crews].each do |crew|
        cabin_crew = FlightCrew.new
        cabin_crew.flight = @flight
        cabin_crew.crew = Crew.find(crew)
        cabin_crew.role = 'cabin_crew'
        cabin_crew.save
        @cabin_crews << cabin_crew
        @flight.flight_crews << cabin_crew
      end
    end
  end

  
  # GET /flight
  # GET /flight.xml
  def index
    @flights = Flight.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @flights }
    end
  end

  # GET /flight/1
  # GET /flight/1.xml
  def show
    
    @flight = Flight.find(params[:id])
    
    @pilot = @flight.flight_crews.detect{|fc| fc.role == 'captain'}
    @copilot = @flight.flight_crews.select{|fc| fc.role == 'copilot'}
    @cabin_crew = @flight.flight_crews.select{|fc| fc.role == 'cabin_crew'}
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @flight }
    end
  end

  # GET /flight/new
  # GET /flight/new.xml
  def new
    @flight = Flight.new
    @all_employees_options = Crew.find(:all).collect {|p| [ p.name, p.id ] } 
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @flight }
    end
  end

  # GET /flight/1/edit
  def edit
    @flight = Flight.find(params[:id])
    
    @pilot = @flight.flight_crews.detect{|fc| fc.role == 'captain'}
    @copilot = @flight.flight_crews.select{|fc| fc.role == 'copilot'}
    @cabin_crew = @flight.flight_crews.select{|fc| fc.role == 'cabin_crew'}
    @all_employees_options = Crew.find(:all).collect {|p| [ p.name, p.id ] } 
  end

  # POST /flight
  # POST /flight.xml
  def create
 
    @flight = Flight.new(params[:flight])
    @flight.free_seats = @flight.airplane.seats
    save_people
    respond_to do |format|
      if @flight.save
        flash[:notice] = 'Flight was successfully created.'
        format.html { redirect_to(@flight) }
        format.xml  { render :xml => @flight, :status => :created, :location => @flight }
        @flight.free_seats = @flight.airplane.seats
      else
        @pilot = @flight.flight_crews.detect{|fc| fc.role == 'captain'}
        @copilot = @flight.flight_crews.select{|fc| fc.role == 'copilot'}
        @cabin_crew = @flight.flight_crews.select{|fc| fc.role == 'cabin_crew'}
        @all_employees_options = Crew.find(:all).collect {|p| [ p.name, p.id ] } 
        format.html { render :action => "new" }
        format.xml  { render :xml => @flight.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /flight/1
  # PUT /flight/1.xml
  def update
    @flight = Flight.find(params[:id])

    save_people
    respond_to do |format|
      if @flight.update_attributes(params[:flight])
        flash[:notice] = 'Flight was successfully updated.'
        format.html { redirect_to(@flight) }
        format.xml  { head :ok }
      else
        @pilot = @flight.flight_crews.detect{|fc| fc.role == 'captain'}
        @copilot = @flight.flight_crews.select{|fc| fc.role == 'copilot'}
        @cabin_crew = @flight.flight_crews.select{|fc| fc.role == 'cabin_crew'}
        @all_employees_options = Crew.find(:all).collect {|p| [ p.name, p.id ] } 
        format.html { render :action => "edit" }
        format.xml  { render :xml => @flight.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /flight/1
  # DELETE /flight/1.xml
  def destroy
    @flight = Flight.find(params[:id])
    @flight.destroy

    respond_to do |format|
      format.html { redirect_to(flights_url) }
      format.xml  { head :ok }
    end
  end
end
