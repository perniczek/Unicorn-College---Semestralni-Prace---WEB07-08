class AddOperatedById < ActiveRecord::Migration
  def self.up
    add_column :flight, :airplane_id, :integer
  end

  def self.down
    remove_column(:flight, :airplane_id)
  end
end
