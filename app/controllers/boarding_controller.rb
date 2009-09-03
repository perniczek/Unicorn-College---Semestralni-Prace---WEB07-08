class BoardingController < ApplicationController
#nabydne lety v budoucnosti a pro ktere jeste nebyl proveden boarding.. uzivatel si z nich vybere
  def index
    @future_flights = []
    flights = Flight.find(:all)
    flights.each do |flight|
      if (flight.leaves_at > Time.now) and (flight.boarded == false)#zme
        @future_flights << flight
      end
    end
    @boarding_tickets = BoardingPass.find(:all)
  end
  #ajaxova metoda ktera vyrendruje partial samotneho radku v druhe tabulce
  def reject
    entry = AirticketItem.find_by_id(params[:entry])
    render :update do |page| 
      page.insert_html 'before', 'footer_before', :partial => 'radek_tabulky', :locals => { :line => params[:line], :info => entry }
      page.replace_html "b_radek_"+params[:line]
    end 
  end
  #ajaxova metoda ktera vyrendruje partial samotneho radku v druhe tabulce po kliknuti na board
  def board
    entry = AirticketItem.find_by_id(params[:entry])
    render :update do |page| 
      page.insert_html 'before', 'b_footer_before', :partial => 'b_radek_tabulky', :locals => { :line => params[:line], :info => entry }
      page.replace_html "radek_"+params[:line]
    end
  end
  #ukonci boarding... 
  def finish_board
    flight = Flight.find_by_id(params[:flight])
    puts flight
    flight.boarded = 1
    flight.save!
    render :update do |page| 
      page["list_of_pas"].hide
      page["msg"].show
    end
  end
  #vyhleda vsechny lety pro dany let a napise...
  def board_flight
    @boarded = [] # list nabordovanych lidi
    good = []
    item = AirticketItem.find_all_by_flight_id(params[:flight])
    if not item == []
      item.each do |pas| #lidi kteri jsou checked
        if pas.checked == true
          good << pas
        end
      end
    end
    puts good
    if item == []
      render :update do |page| 
        page["flights"].hide
        page.insert_html "after", "flights", :partial => 'nothing_to_board'
      end
    else
      render :update do |page|
        page["flights"].hide
        page.insert_html "after", "flights", :partial => 'list_of_pass', :locals => { :item => good }
      end
    end
  end
  
end
