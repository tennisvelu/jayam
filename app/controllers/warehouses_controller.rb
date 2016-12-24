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
  end

  # GET /warehouses/new
  def new
    @warehouse = Warehouse.new
    @warehouse.build_contact
    @warehouse.build_address

  end

  # GET /warehouses/1/edit
  def edit
  end

  # POST /warehouses
  # POST /warehouses.json
  def create
    @warehouse = Warehouse.new(warehouse_params)
    respond_to do |format|

      if @warehouse.save
        #byebug
        grade=Grade.where(:company_id=>@warehouse.company_id).pluck(:id)
        (0..grade.count-1).map do |i|
          Stock.create(:grade_id=>i,:book_stock=>0,:physical_stock=>0,:warehouse_id=>@warehouse.company_id)
            end
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
    @warehouse.destroy
     Contact.find(@warehouse.contact_id).destroy
     Address.find(@warehouse.address_id).destroy
     respond_to do |format|
      format.html { redirect_to warehouses_url, notice: 'Warehouse was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

   def warehouse_admin
     unless User.find(session[:user_id]).role.role_type=="Super Admin"
      user_id=session[:user_id]
      @warehouse_session_id=Warehouse.admin_warehouse_id(user_id)#User.find(session[:user_id]).warehouse_id
     else
       unless params[:id].present?
         @warehouse_session_id=params[:format]
       else
         @warehouse_session_id=params[:id]
       end
     end
    warehouse_session_id=@warehouse_session_id
    @inward_total=Inward.where(:warehouse_id=>@warehouse_session_id).pluck(:total_quantity).compact.sum
    @damage=Damage.new
    @warehouse_stock=Warehouse.warehouse_stock(params,warehouse_session_id)
    @direct_sale=Warehouse.warehouse_direct_sale(params,warehouse_session_id)
    @damage1=Warehouse.warehouse_damage(params,warehouse_session_id)
    #@damage1=@damage1_cal.paginate(:page => params[:page], :per_page => 20)
    @inward=Warehouse.warehouse_inward(params,warehouse_session_id)
    #@inward=@inward_cal.paginate(:page => params[:page], :per_page => 20)
    @approve_reject_id=Warehouse.approve_reject_report(params,warehouse_session_id)
    @inward_consolidate=Warehouse.inward_consolidate(params,warehouse_session_id)
    @outward=Warehouse.outward_date(params,warehouse_session_id)
   # @outward=@outward_cal.paginate(:page => params[:page], :per_page => 10)
  end  
  
  def damage_entry
   warehouse_session_id=params[:id]
   Warehouse.damage_entries(params,warehouse_session_id)
   redirect_to :action=>"warehouse_admin",:id=>params[:id]
  end

  def inward_date 
    to=(Date.parse(params[:to])+1).strftime("%Y-%m-%d")
    redirect_to :action=>"warehouse_admin",:from=>params[:from],:to=>to,:id=>params[:id],:type=>params[:type]
  end 

  def outward_date 
     to=(Date.parse(params[:to])+1).strftime("%Y-%m-%d")
    redirect_to :action=>"warehouse_admin",:from=>params[:from],:to1=>to,:id=>params[:id]
  end 

  def damage_date 
    to=(Date.parse(params[:to])+1).strftime("%Y-%m-%d")
    redirect_to :action=>"warehouse_admin",:from=>params[:from],:to2=>to,:id=>params[:id]
  end

  def direct_sale
    to=(Date.parse(params[:to])+1).strftime("%Y-%m-%d")
    redirect_to :action=>"warehouse_admin",:from=>params[:from],:to3=>to,:id=>params[:id]
  end  

  def inward_consolidate
    to=(Date.parse(params[:to])+1).strftime("%Y-%m-%d")
    redirect_to :action=>"warehouse_admin",:from=>params[:from],:to4=>to,:id=>params[:id]
  end  

  def approve_reject_report
  to=(Date.parse(params[:to])+1).strftime("%Y-%m-%d")
  redirect_to :action=>"warehouse_admin",:from=>params[:from],:to5=>to,:id=>params[:id],:range=>params[:range]
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
