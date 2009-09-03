class CreateFlightCrews < ActiveRecord::Migration
  def self.up
    create_table :flight_crew do |t|
      t.integer :flight_id
      t.integer :crew_id
      t.string :role

      t.timestamps
    end
  end

  def self.down
    drop_table :flight_crew
  end
end  
