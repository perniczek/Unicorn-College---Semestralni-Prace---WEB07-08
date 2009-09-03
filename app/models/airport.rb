class Airport < ActiveRecord::Base
  has_many :flights_to, :class_name => 'Flight', :foreign_key => :airport_to_id
  has_many :flights_from, :class_name => 'Flight', :foreign_key => :airport_from_id
  
  validates_presence_of :code, :name, :inbound_fee, :outbound_fee
  validates_numericality_of :inbound_fee, :outbound_fee, :message => 'Prices have to be entered as numbers.'
  validates_length_of(:name, :in => 2..100, :message => "The airport name can be anywhere from 2 to 100 characters long.")
  
end
