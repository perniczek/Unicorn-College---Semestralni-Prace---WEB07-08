class EditStuff < ActiveRecord::Migration
  def self.up
    remove_column :airticket, :cc_nr
    remove_column :customer, :pass_nr
    add_column :airticket, :cc_nr, :text
  end

  def self.down
  end
end
