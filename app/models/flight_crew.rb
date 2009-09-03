class FlightCrew < ActiveRecord::Base
 belongs_to :flight
 belongs_to :crew
 
 validates_presence_of :role
 validates_inclusion_of :role, :in => ['captain', 'copilot','cabin_crew']
end 