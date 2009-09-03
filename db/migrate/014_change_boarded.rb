class ChangeBoarded < ActiveRecord::Migration
  def self.up
    remove_column(:flight, :boarded)
    add_column :flight,:boarded,:boolean, :default => false
  end

  def self.down
  end
end
