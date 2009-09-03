class AirticketItem < ActiveRecord::Base
  belongs_to :airticket
  belongs_to :flight
  has_one :boarding_pass  
  #has_one :palubni_vstupenka, :class_name => 'BoardingPass'
end
