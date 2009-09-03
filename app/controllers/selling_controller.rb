class SellingController < ApplicationController
  #vyhleda vsechny letiste
  def index
    @airports = Airport.find(:all)
  end
  #vyhleda lety v databazi dle zadanych kriterii
  def pick
    @found_flights = []
    date = Time.local(params['post']['departure(1i)'], params['post']['departure(2i)'], params['post']['departure(3i)'])
    potentional_flights = Flight.find_all_by_airport_from_id_and_airport_to_id(params['post']['from'],params['post']['to'])
    potentional_flights.each do |flight|
      if flight.leaves_at.to_i.between?(date.to_i-params['post']['offby'].to_i, date.to_i+86396+params['post']['offby'].to_i) and flight.boarded == false and  flight.free_seats > 0
        @found_flights << flight
      end
    end
  end
  #ulozi udaje o poctu a vybranem letu do sessions
  def passangers_pass
    @number_of_passangers = params['post']['number_of_pass']
    session["number_of_pass"] = params['post']['number_of_pass']
    session["flights"] = params['post']['picked']
  end
  #pomocna metoda na vyhledavani pasazeru ktere uz mam v databazi a na pozadavek na zapis tech novych
  def passangers_add
    @passengers_indb = []
    @passengers_new = []
    session["number_of_pass"].to_i.times do |iter|
      pass = Customer.find_by_birth_number(params["post"]["id"+(iter+1).to_s])
      if pass.nil?
        pass = Customer.new("birth_number" => params["post"]["id"+(iter+1).to_s])
        @passengers_new << pass
      else
        @passengers_indb << pass
      end
    end
    session["pass_indb"] = @passengers_indb
  end
  #rendrovani samotneho radku tabulky a tvoreni pasazeru v databazi
  def add_item_ajax
    @passer = Customer.new("first_name" => params["post"]["first_name"],"surname" => params["post"]["surname"],"birth_number" => (params["post"]["birth_number"]).to_i, "address" => params["post"]["address"])
    if @passer.save
      session["pass_indb"] << @passer
      render :update do |page| 
        page.insert_html 'before', 'paticka', :partial => 'radek_tabulky', :locals => { :new_passanger => @passer }
        page["novy_pasazer_"+params[:id]].toggle
        if session["pass_indb"].size == session["number_of_pass"].to_i
          page["submitbut"].show
        end
      end
    else
    end
  end
  #overview letu
  def overview
    @flights = Flight.find_by_id(session["flights"])
  end
  #vytvoreni vlastni letenky...odecte sedadlo
  def add_ticket
    @array = []
    params[:passer].each do |passanger|
      number = rand(1000000-1)
      ticket =  Airticket.new("reservation_code" => number, "price" => params[:price], "customer_id" => passanger , "cc_nr" => params["post"]["cr"])
      if ticket.save
        item = AirticketItem.new("flight_id" => params[:flight_id], "airticket_id" => ticket.id)
        flight = Flight.find_by_id(params[:flight_id])
        flight.free_seats -= 1
        item.save
        @array << [ticket,item]
      else
        puts item.errors
        #zde by se hodilo delat validacni chyby,... kdyz problem nastane obrazovka se nezmeni
      end
    end
    if not @array == []
      render :update do |page| 
        page["add_here"].hide
        page.insert_html 'before', 'here', :partial => 'tabulka', :locals => { :pass => @array }
      end
    end
  end
end
