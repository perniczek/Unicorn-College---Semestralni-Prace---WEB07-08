class AddPriceAndStuff < ActiveRecord::Migration
  def self.up
    add_column :flight, :free_seats, :integer
    add_column :flight, :price, :integer
    add_column :flight, :boarded, :boolean
  end

  def self.down
    remove_column :flight, :free_seats
    remove_column :flight, :price
    remove_column :flight, :boarded
  end
end
