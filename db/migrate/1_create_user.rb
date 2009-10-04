class CreateUser < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :firstname, :string
      t.column :lastname, :string
      t.column :token, :string
      t.column :secret, :string
      t.column :currentcity, :integer
      t.column :photourl, :string
      t.column :userid, :integer
    end
  end
  
  def self.down
    drop_table :user
  end
  
end