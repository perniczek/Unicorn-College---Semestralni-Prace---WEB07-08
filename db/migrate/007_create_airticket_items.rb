class CreateAirticketItems < ActiveRecord::Migration
  def self.up
    create_table :airticket_item do |t|
      t.integer :flight_id, :airticket_id
      t.timestamps
    end
  end

  def self.down
    drop_table :airticket_item
  end
end
