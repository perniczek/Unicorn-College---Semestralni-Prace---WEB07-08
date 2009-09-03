class CrewsController < ApplicationController

  def index
    @crews = Crew.find(:all)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @crews }
    end
  end

  def new
    @crews = Crew.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @crews }
    end
  end

  def create
    @crews = Crew.new(params[:crew])

    respond_to do |format|
      if @crews.save
        flash[:notice] = 'Crew was successfully created.'
        format.html { redirect_to(@crews) }
        format.xml  { render :xml => @crews, :status => :created, :location => @crews }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @crews.errors, :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @crews = Crew.find(params[:id])
  end

  def update
    @crews = Crew.find(params[:id])

    respond_to do |format|
      if @crews.update_attributes(params[:crew])
        flash[:notice] = 'Crew was successfully updated.'
        format.html { redirect_to(@crews) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @crews.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @crews = Crew.find(params[:id])
    @crews.destroy

    respond_to do |format|
      format.html { redirect_to(crews_url) }
      format.xml  { head :ok }
    end
  end

  
def show
    
  @crews = Crew.find(params[:id])
  respond_to do |format|
    format.html # index.html.erb
    format.xml  { render :xml => @crews }
  end
end
end
