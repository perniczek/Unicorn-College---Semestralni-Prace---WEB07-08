class AddCc < ActiveRecord::Migration
  def self.up
    add_column :airticket, :cc_nr, :integer
  end

  def self.down
    remove_column :airticket, :cc_nr
  end
end
