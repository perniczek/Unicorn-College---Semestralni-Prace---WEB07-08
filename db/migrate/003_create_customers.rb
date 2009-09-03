class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customer do |t|
      t.string :first_name
      t.string :surname
      t.string :birth_number, :limit => 10
      t.timestamps
    end
  end

  def self.down
    drop_table :customer
  end
end
