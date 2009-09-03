class Customer < ActiveRecord::Base
  has_many :airtickets
  
  validates_presence_of :first_name, :surname, :birth_number
  validates_format_of :birth_number, :with => /^[0-9]{2,2}[01235678][0-9][0123][0-9][0-9]{3,4}$/, :message => "Wrong birth number format"
end
