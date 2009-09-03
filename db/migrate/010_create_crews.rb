class CreateCrews < ActiveRecord::Migration
  def self.up
    create_table :crew do |t|
      t.string :first_name
      t.string :surname
      t.string :empno
      t.float :salary
      t.date :birthday
      t.integer :airport_id
      t.timestamps
    end
  end

  def self.down
    drop_table :crew
  end
end 