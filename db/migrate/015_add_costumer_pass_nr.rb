class AddCostumerPassNr < ActiveRecord::Migration
  def self.up
    add_column :customer, :pass_nr, :integer
  end

  def self.down
  end
end
