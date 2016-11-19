class Company < ActiveRecord::Base
  belongs_to :address
  belongs_to :contact 
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :contact

  def self.super_admin(params)
    @damage=[]
    Warehouse.ids.map do |j|
    @warehouse_name=Warehouse.find(j).warehouse_name 
   unless params[:to].present?
    @inward_damage=Inward.where(:warehouse_id=>j).where(:created_at=>Date.today-10..Date.today).pluck(:damage_bags_count).compact.sum
   @warehouse_damage=Damage.where(:warehouse_id=>j).where(:created_at=>Date.today-10..Date.today).pluck(:bags_count).compact.sum
   @damage << [@warehouse_name,@inward_damage,@warehouse_damage]
  else
   @inward_damage =Inward.where(:warehouse_id=>j).where(:created_at=>params[:from]..params[:to]).pluck(:damage_bags_count).compact.sum
     @warehouse_damage=Damage.where(:warehouse_id=>j).where(:created_at=>params[:from]..params[:to]).pluck(:bags_count).compact.sum
     @damage << [@warehouse_name,@inward_damage,@warehouse_damage]
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
      # byebug
     params[:outward_ids].map {|i| Outward.find(i).update(:status=>1)}
     params[:outward_ids].map {|i| OutwardApproval.find_by(:outward_id=>i).update(:status=>1)}
   else
     params[:outward_ids].map {|i| Outward.find(i).update(:status=>2)}
     params[:outward_ids].map {|i| OutwardApproval.find_by(:outward_id=>i).update(:status=>2)}

   end
end

  def self.damage_date(params)
    #params[:from]
    #params[:to]
    #Damage.
  end
end
