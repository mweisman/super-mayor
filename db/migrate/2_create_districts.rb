class CreateDistricts < ActiveRecord::Migration
  def self.up
    create_table :districts do |t|
      t.column :districtname, :string
      t.column :geometry, :blob
    end
  end
  
  def self.down
    drop_table :districts
  end
  
end