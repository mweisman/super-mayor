class User < ActiveRecord::Base
  has_many :districts, :through => :magic
  has_many :magic
end