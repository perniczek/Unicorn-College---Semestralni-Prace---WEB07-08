class AddChecked < ActiveRecord::Migration
  def self.up
    add_column :airticket_item, :checked, :boolean, :default => false
  end

  def self.down
    remove_column :airticket_item, :checked
  end
end
