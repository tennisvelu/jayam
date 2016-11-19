class Outward < ActiveRecord::Base
	has_many :outward_manufacture_detail
	has_one :outward_approval
	belongs_to :warehouse
end
