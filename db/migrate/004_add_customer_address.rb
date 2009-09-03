class AddCustomerAddress < ActiveRecord::Migration
  def self.up
    add_column :customer, :address, :text
  end

  def self.down
    remove_column :customer, :address
  end
end
