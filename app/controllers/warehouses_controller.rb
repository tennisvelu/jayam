class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update, :destroy]

  # GET /warehouses
  # GET /warehouses.json
  def index
    @warehouses = Warehouse.all
  end

  # GET /warehouses/1
  # GET /warehouses/1.json
  def show
   #@warehouse=Warehouse.find(params[:id])
  end

  # GET /warehouses/new
  def new
    @warehouse = Warehouse.new
    @warehouse.build_contact
    @warehouse.build_address

  end

  # GET /warehouses/1/edit
  def edit
   #@warehouse=Warehouse.find(params[:id])
  end

  # POST /warehouses
  # POST /warehouses.json
  def create
    @warehouse = Warehouse.new(warehouse_params)

    respond_to do |format|
      if @warehouse.save
        format.html { redirect_to @warehouse, notice: 'Warehouse was successfully created.' }
        format.json { render :show, status: :created, location: @warehouse }
      else
        format.html { render :new }
        format.json { render json: @warehouse.errors, status: :unprocessable_entity }
      end
       Address.find(@warehouse.address_id).update_attributes(:city=>params[:city],:state=>params[:state],:country=>params[:country])
    end
  end

  # PATCH/PUT /warehouses/1
  # PATCH/PUT /warehouses/1.json
  def update
    #@warehouse=Warehouse.find(params[:id])
    respond_to do |format|
      if @warehouse.update(warehouse_params)
        format.html { redirect_to @warehouse, notice: 'Warehouse was successfully updated.' }
        format.json { render :show, status: :ok, location: @warehouse }
      else
        format.html { render :edit }
        format.json { render json: @warehouse.errors, status: :unprocessable_entity }
      end
       Address.find(@warehouse.address_id).update_attributes(:city=>params[:city],:state=>params[:state],:country=>params[:country])
    end
  end

  # DELETE /warehouses/1
  # DELETE /warehouses/1.json
  def destroy
    #@warehouse=Warehouse.find(params[:id])
    @warehouse.destroy
     Contact.find(@warehouse.contact_id).destroy
     Address.find(@warehouse.address_id).destroy
    respond_to do |format|
      format.html { redirect_to warehouses_url, notice: 'Warehouse was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

   def warehouse_admin

    @damage=Damage.new
    unless params[:warehouse].present?
    @warehouse_session_id=User.find(session[:user_id]).warehouse_id
    else
    @warehouse_session_id=params[:warehouse][:id]
    end
    unless params[:to2].present?
    @damage1=Damage.where(:warehouse_id=>@warehouse_session_id).where(:updated_at=>Date.yesterday..Time.now).pluck(:damage_entry_date,:week_no,:bags_count)
    else
    @damage1=Damage.where(:warehouse_id=>@warehouse_session_id).where(:updated_at=>params[:from]..params[:to2]).pluck(:damage_entry_date,:week_no,:bags_count)
    end
    unless params[:to1].present?
    @current_outward=Outward.where(:warehouse_id=>@warehouse_session_id).where(:payment_type=>0).where(:created_at=>Date.yesterday..Time.now).pluck(:outward_number,:outward_date,:total_quantity)
    @advance_outward=Outward.where(:warehouse_id=>@warehouse_session_id).where(:payment_type=>1).where(:status=>3).where(:updated_at=>Date.yesterday-10..Time.now).pluck(:outward_number,:outward_date,:total_quantity)
    @suspense_outward=Outward.where(:warehouse_id=>@warehouse_session_id).where(:payment_type=>2).where(:status=>4).where(:created_at=>Date.yesterday-10..Time.now).pluck(:outward_number,:outward_date,:total_quantity)
   else
   @current_outward=Outward.where(:warehouse_id=>@warehouse_session_id).where(:payment_type=>0).where(:created_at=>params[:from]..params[:to1]).pluck(:outward_number,:outward_date,:total_quantity)
    @advance_outward=Outward.where(:warehouse_id=>@warehouse_session_id).where(:payment_type=>1).where(:status=>3).where(:updated_at=>params[:from]..params[:to1]).pluck(:outward_number,:outward_date,:total_quantity)
    @suspense_outward=Outward.where(:warehouse_id=>@warehouse_session_id).where(:payment_type=>2).where(:status=>4).where(:updated_at=>params[:from]..params[:to1]).pluck(:outward_number,:outward_date,:total_quantity)
  end
    @inward_total=Inward.where(:warehouse_id=>@warehouse_session_id).pluck(:total_quantity).compact.sum
  end  
  
  def damage_entry
  @week_no=params[:week_no]
  @bags_count=params[:bags_count]
  @week_no.map do |i|
    @bags_count.map do |j|
      Damage.create(:damage_entry_date=>Date.today,:week_no=>i,:bags_count=>j,:warehouse_id=>User.find(session[:user_id]).warehouse_id)
    end
  end
  redirect_to :action=>"warehouse_admin"
  end

  def inward_date 
    to=(Date.parse(params[:to])+1).strftime("%Y-%m-%d")
    redirect_to :action=>"warehouse_admin",:from=>params[:from],:to=>to
  end 

  def outward_date 
     to=(Date.parse(params[:to])+1).strftime("%Y-%m-%d")
    redirect_to :action=>"warehouse_admin",:from=>params[:from],:to1=>to
  end 

  def damage_date 
    to=(Date.parse(params[:to])+1).strftime("%Y-%m-%d")
    redirect_to :action=>"warehouse_admin",:from=>params[:from],:to2=>to
  end

  def direct_sale
    to=(Date.parse(params[:to])+1).strftime("%Y-%m-%d")
    redirect_to :action=>"warehouse_admin",:from=>params[:from],:to3=>to
  end  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_warehouse
      @warehouse = Warehouse.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def warehouse_params
      params.require(:warehouse).permit(:warehouse_name, :contact_id, :address_id, :company_id, :isactive, :created_by, :updated_by,contact_attributes: [:email,:telephone_number, :mobile_number], address_attributes: [:address1, :post_code, :city, :state, :country])
    end
end
