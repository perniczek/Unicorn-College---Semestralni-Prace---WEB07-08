class CreateAirplanes < ActiveRecord::Migration
  def self.up
    create_table :airplane do |t|
      t.string :plane_type
      t.string :code, :limit => 6
      t.integer :seats, :default => 120, :limit => 4
      t.datetime :made_when
      t.timestamps
    end
  end

  def self.down
    drop_table :airplane
  end
end
