class Airticket < ActiveRecord::Base
  belongs_to :customer
  has_many :airticket_items

  validates_presence_of :reservation_code, :customer_id, :cc_nr
  validates_numericality_of :price, :message => 'Prices have to be entered as numbers.'
  validates_format_of :reservation_code, :with => /^[0-9a-z]{6,6}$/, :message => "Wrong reservation code format (6 characters long, only lowercase letters and numbers)"
end
