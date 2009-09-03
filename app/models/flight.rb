class Flight < ActiveRecord::Base
  belongs_to :airport_from, :class_name => 'Airport'
  belongs_to :airport_to, :class_name => 'Airport'
  has_many :airticket_items
  has_many :airtickets, :through => :airticket_items
  has_many :flight_crews
  has_many :crews, :through => :flight_crews
  belongs_to :airplane
  validates_presence_of :code, :airport_from_id, :airport_to_id,:price
  validates_numericality_of :price
  def validate_on_create
    errors.add(:leaves_at, 'New flights have to be in future') if leaves_at <= Time.now - 5
  end
end
