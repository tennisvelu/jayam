class User < ActiveRecord::Base
  belongs_to :address
  belongs_to :contact
  belongs_to :role 
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :contact
  validates_uniqueness_of :user_name
 
end
