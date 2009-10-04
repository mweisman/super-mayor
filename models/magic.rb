class Magic < ActiveRecord::Base
  set_table_name :magic
  has_one :user
  has_one :district
end