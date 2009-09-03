class CreateAirports < ActiveRecord::Migration
  def self.up
    create_table :airport do |t|
      t.string :code, :name, :gps_position
      t.float :inbound_fee, :outbound_fee
      t.text :details
      t.timestamps
    end
  end

  def self.down
    drop_table :airport
  end
end
