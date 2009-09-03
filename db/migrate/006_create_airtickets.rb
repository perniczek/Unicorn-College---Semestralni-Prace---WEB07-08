class CreateAirtickets < ActiveRecord::Migration
  def self.up
    create_table :airticket do |t|
      t.string :reservation_code
      t.float :price
      t.integer :customer_id
      t.timestamps
    end
  end

  def self.down
    drop_table :airticket
  end
end
