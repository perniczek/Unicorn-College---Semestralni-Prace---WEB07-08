class AirplanesController < ApplicationController
  # GET /airplane
  # GET /airplane.xml
  #Pomocna metoda pro zobrazeni vsech letadel
  def index
    @airplanes = Airplane.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @airplanes }
    end
  end

  # GET /airplane/1
  # GET /airplane/1.xml
  #Vyhleda letadlo podle jeho ID a pak nasledne view o nem vypise udaje
  def show
    @airplane = Airplane.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @airplane }
    end
  end

  # GET /airplane/new
  # GET /airplane/new.xml
  #Zaklada nove letadlo
  def new
    @airplane = Airplane.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @airplane }
    end
  end

  # GET /airplane/1/edit
  #upravuje letadlo...
  def edit
    @airplane = Airplane.find(params[:id])
  end

  # POST /airplane
  # POST /airplane.xml
  #volana z new.... vytvori a ulozi samotne udaje o novem letadlu
  def create
    @airplane = Airplane.new(params[:airplane])

    respond_to do |format|
      if @airplane.save
        
        flash[:notice] = 'Airplane was successfully created.'
        format.html { redirect_to(@airplane) }
        format.xml  { render :xml => @airplane, :status => :created, :location => @airplane }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @airplane.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /airplane/1
  # PUT /airplane/1.xml
  def update
    @airplane = Airplane.find(params[:id])

    respond_to do |format|
      if @airplane.update_attributes(params[:airplane])
        flash[:notice] = 'Airplane was successfully updated.'
        format.html { redirect_to(@airplane) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @airplane.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /airplane/1
  # DELETE /airplane/1.xml
  def destroy
    @airplane = Airplane.find(params[:id])
    @airplane.destroy

    respond_to do |format|
      format.html { redirect_to(airplanes_url) }
      format.xml  { head :ok }
    end
  end
end
