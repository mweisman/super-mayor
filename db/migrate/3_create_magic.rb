class CreateMagic < ActiveRecord::Migration
  def self.up
    create_table :magic do |t|
      t.belongs_to :user, :district
      i.integer :mayorships
    end
  end
  
  def self.down
    drop_table :magic
  end
  
end