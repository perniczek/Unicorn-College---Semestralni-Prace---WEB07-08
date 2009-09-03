class Crew < ActiveRecord::Base
  belongs_to :airport
  has_many :flight_crews
  has_many :flights, :through => :flight_crews
 
  validates_presence_of :surname, :first_name, :empno, :salary
  validates_numericality_of :salary, :only_integer => false
  validates_length_of :surname, :within => 2..30
  validates_length_of :first_name, :within => 2..30
  #validates_format_of :empno, :with => /^bae[0-9]{3}$/
  validates_uniqueness_of :empno           #not in the assignment, validate that employee numbers are unique
  
  def name
    return first_name + " " +surname
  end
end  
