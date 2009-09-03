class Airplane < ActiveRecord::Base
  has_many :flights, :class_name => 'Flight', :foreign_key => :airport_from_id
  validates_presence_of :plane_type,:code,:seats
  validates_numericality_of :seats
end
