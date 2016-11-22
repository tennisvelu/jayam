class Company < ActiveRecord::Base
  belongs_to :address
  belongs_to :contact 
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :contact

  def self.super_admin(params)
    damage=[]
    Warehouse.ids.map do |j|
    @warehouse_name=Warehouse.find(j).warehouse_name 
   unless params[:to].present?
      @inward_damage=Inward.where(:warehouse_id=>j).where(:created_at=>Date.today-10..Date.today).pluck(:damage_bags_count).compact.sum
      @warehouse_damage=Damage.where(:warehouse_id=>j).where(:created_at=>Date.today-10..Date.today).pluck(:bags_count).compact.sum
      damage << [@warehouse_name,@inward_damage,@warehouse_damage]
   else
     @inward_damage =Inward.where(:warehouse_id=>j).where(:created_at=>params[:from]..params[:to]).pluck(:damage_bags_count).compact.sum
     @warehouse_damage=Damage.where(:warehouse_id=>j).where(:created_at=>params[:from]..params[:to]).pluck(:bags_count).compact.sum
     damage << [@warehouse_name,@inward_damage,@warehouse_damage]
  	end
    end
  end	

  def self.location_approve(params)
   if params["commit"]=="approve"
    params[:location_ids].map {|i| Location.find(i).update(:status=>1)}
    else
    params[:location_ids].map {|i| Location.find(i).update(:status=>2)}
   end
   end	

   def self.suspense_advance_approve(params)
   	if params["commit"]=="approve"
     params[:outward_ids].map {|i| Outward.find(i).update(:status=>1)}
     params[:outward_ids].map {|i| OutwardApproval.find_by(:outward_id=>i).update(:status=>1)}
   else
     params[:outward_ids].map {|i| Outward.find(i).update(:status=>2)}
     params[:outward_ids].map {|i| OutwardApproval.find_by(:outward_id=>i).update(:status=>2)}

   end
end

def self.warehouse_stock(params)
warehouse_stock=[]
Warehouse.ids.map do |l|
warehouse_name=Warehouse.find(l).warehouse_name
inward_total=Inward.where(:warehouse_id=>l).pluck(:total_quantity).compact.sum
outward_current=Outward.where(:payment_type=>0).pluck(:total_quantity).compact.sum
outward_advance_bill=Outward.where(:payment_type=>1).where(:status=>4).pluck(:total_quantity).compact.sum
outward_suspense_bill=Outward.where(:payment_type=>2).where(:status=>4).pluck(:total_quantity).compact.sum
outward_suspense_dispatch=Outward.where(:payment_type=>2).where(:status=>3).pluck(:total_quantity).compact.sum
by_book=inward_total-outward_current-outward_advance_bill-outward_suspense_bill
physical_stock=inward_total-outward_current-outward_suspense_dispatch+outward_advance_bill
warehouse_stock << [warehouse_name,by_book,physical_stock]
end
end

def self.damage_date(params)
   
end

def self.direct_sale(params)
@direct=[]
Warehouse.ids.map do |x|
warehouse_name=Warehouse.find(x).warehouse_name
unless params[:to3].present?
@direct_sale_bags = Outward.where(:warehouse_id=>x).where(:type_of_load=>1).where(:created_at=>Date.today-10..Date.today+1).pluck(:total_quantity).compact.sum
else
@direct_sale_bags = Outward.where(:warehouse_id=>x).where(:type_of_load=>1).where(:created_at=>params[:from]..params[:to3]).pluck(:total_quantity).compact.sum
end
@direct << [warehouse_name,@direct_sale_bags]
end
end


def self.inward_return(params)
inward_return_bags=[]
Warehouse.ids.map do |k|
warehouse_name=Warehouse.find(k).warehouse_name
unless params[:to1].present?
@return_bags=Inward.where(:warehouse_id=>k).where(:return=>true).pluck(:total_quantity).compact.sum
else
@return_bagsInward.where(:warehouse_id=>k).where(:created_at=>params[:from]..params[:to1]).where(:return=>true).pluck(:total_quantity).compact.sum
end
inward_return_bags << [warehouse_name,@return_bags]
end  
end

def self.approve_reject_report(params)
if params[:to2].present?
approval_reject_id=OutwardApproval.where(:status=>[1,2]).where(:updated_at=>params[:from]..params[:to2])
else
approval_reject_id=OutwardApproval.where(:status=>[1,2])
end
end

end
