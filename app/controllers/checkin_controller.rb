class CheckinController < ApplicationController
#Kde nic tu nic :D
  def index
  end
  #skova puvodni tabulku, aby to vypadalo ajaxove.... a vyrendruje vyhledavani podle  pasazera
  def show_passanger
    render :update do |page| 
      page["first_table"].hide
      page.insert_html 'after', 'first_table', :partial => 'passanger'
    end
  end 
  #skova puvodni tabulku, aby to vypadalo ajaxove.... a vyrendruje vyhledavani podle  rezervacniho cisla
 
  def show_ticket
    render :update do |page| 
      page["first_table"].hide
      page.insert_html 'after', 'first_table', :partial => 'ticket'
    end
  end
  #Vytvrori boarding ticket... vytiskne na obrazovku boarding pass.. ulozi udaje o zavazadlech
  def check_pass
    sold_tickets = BoardingPass.find_all_by_airticket_item_id(params[:item_info])
    boarding = BoardingPass.new("airticket_item_id" => params[:item_info], "luggage_pcs" => params["post"]["laguage_count"],"seat_no" => sold_tickets.size+1, "luggage_weight"=> params["post"]["laguage_weight"])
    p boarding
    if boarding.save
      flight = AirticketItem.find(params[:item_info])
      flight.checked = true
      flight.save
      render :update do |page| 
        page["laguage"].hide
        page.insert_html "after", "laguage", :partial => 'boarding_pass', :locals => { :pass => boarding }
      end
    end
  end
  #zjisti kolik ma cestujiic zavazaedl
  def get_laguage
    render :update do |page| 
      page["checking_table"].hide
      page.insert_html "after", "checking_table", :partial => 'laguages', :locals => { :item_info => params[:item] }
    end
  end
  #hleda pasazera podle rezervacniho kodu... jestli nenajde vytiskne chybovou hlasku .. jestli jo tak se zeptat na zavazadla
  def find_passanger_by_rc
    airticket = Airticket.find_by_reservation_code(params["post"]["code"])
    p airticket.id
    if airticket.nil?
      render :update do |page| 
        page["table_div"].hide
        page.insert_html "after", "results", :partial => 'nothing_found'
      end
    else  
      item = AirticketItem.find_by_airticket_id(airticket.id)
      if not item.checked == true
        render :update do |page| 
          page["table_div"].hide
          page.insert_html "after", "results", :partial => 'laguages', :locals => { :item_info => item }
        end
      else
        render :update do |page| 
          page["table_div"].hide
          page.insert_html "after", "results", :partial => 'nothing_found'
        end
      end
    end
  end
  
  #hleda pasazera podle jmena prijmeni a cisla karty... jestli nenajde vytiskne chybovou hlasku .. jestli jo tak se zeptat na zavazadla
  def find_passanger_by_cc
    item = []
    credit_card = params["post"]["cr1"].to_s + params["post"]["cr2"].to_s + params["post"]["cr3"].to_s + params["post"]["cr4"].to_s
    #tady je to id spatne cstomer.id nesmi vracet id objektu v ruby ale id v tabulce.. opravdu netusim co s tim
    #customer = Customer.find_all_by_first_name_and_surname(params["post"]["first_name"],params["post"]["surname"])
    customer = Customer.find(:all, :conditions => ['first_name = :FN AND surname = :SN', { :FN => params["post"]["first_name"], :SN => params["post"]["surname"] } ])
    puts customer.object_id
    puts customer.id
    p customer
    real_flights = Airticket.find_all_by_customer_id_and_cc_nr(1088155134,credit_card) #zde ma byt customer id ale nevim jak ho z toho dostat
    if real_flights == []
      render :update do |page| 
        page["table_div"].hide
        page.insert_html "after", "results", :partial => 'nothing_found'
      end
    else
      real_flights.each do |flight|
        flight_item = AirticketItem.find_by_airticket_id(flight.id)
        if not flight_item.checked == true
          item << flight_item
        end
      end
      if item == []
        render :update do |page| 
          page["table_div"].hide
          page.insert_html "after", "results", :partial => 'nothing_found'
        end
      else
        render :update do |page| 
          page["table_div"].hide
          page.insert_html 'after', 'results', :partial => 'check_following_tickets', :locals => { :flights => item }
        end
      end
    end
  end
end
