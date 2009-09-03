class TestController < ApplicationController

  def index
  end
  def code_changed
    @found_airport = Airport.find_by_code(params[:airport][:code])
    respond_to {|format| format.js}
  end
  
  def basic
    
    render :action => :basic
  end
  def pass
    
  end
  def form
    @airport = Airport.find_by_code('PRG')
  end

  def form_ar
    @airport = Airport.find_by_code('PRG')
  end
  
  def airport_as_text
    @airport = Airport.find(params[:id])
    send_data @airport.to_yaml, :type=>'text/plain', :filename => "Airport-#{@airport.name}"
  end
  
  def submit_error
    nil.some_method
  end
end
