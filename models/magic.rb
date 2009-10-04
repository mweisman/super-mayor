class Magic < ActiveRecord::Base
  has_one :user
  has_one :district
end