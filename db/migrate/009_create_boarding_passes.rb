class CreateBoardingPasses < ActiveRecord::Migration
  def self.up
    create_table :boarding_pass do |t|
      t.integer :airticket_item_id
      t.integer :luggage_pcs
      t.float :luggage_weight
      t.string :seat_no
      t.timestamps
    end
  end

  def self.down
    drop_table :boarding_pass
  end
end
