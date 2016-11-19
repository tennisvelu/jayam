class Warehouse < ActiveRecord::Base
  has_many :outward
  has_many :location
  belongs_to :address
  belongs_to :contact 
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :contact

end
