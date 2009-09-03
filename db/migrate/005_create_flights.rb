class CreateFlights < ActiveRecord::Migration
  def self.up
    create_table :flight do |t|
      t.string :code
      t.integer :airport_to_id, :airport_from_id
      t.datetime :leaves_at
      t.timestamps
    end
  end

  def self.down
    drop_table :flight
  end
end
