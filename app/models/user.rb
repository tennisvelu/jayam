class User < ActiveRecord::Base
  belongs_to :address
  belongs_to :contact 
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :contact
end
