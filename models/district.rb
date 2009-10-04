class District < ActiveRecord::Base
  has_many :magic
  has_many :users, :through => :magic
  
  def super_mayor
    self.magic.find(:first, :order => 'mayorships DESC')
  end
end