class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  # GET /companies
  # GET /companies.json
  def index
    @companies = Company.all
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
    @company.build_contact
    @company.build_address

  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
       Address.find(@company.address_id).update_attributes(:city=>params[:city],:state=>params[:state],:country=>params[:country])
    end
  end

  # PATCH/PUT /companies/1
  # PATCH/PUT /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
       Address.find(@company.address_id).update_attributes(:city=>params[:city],:state=>params[:state],:country=>params[:country])
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company.destroy
    respond_to do |format|
      format.html { redirect_to companies_url, notice: 'Company was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def super_admin
    @warehouse=Warehouse.new
    #@damage=Company.super_admin(params)
    @location1=Location.all
    @outward=Outward.new
    @location=Location.where(:status=>0)
    @ids=Outward.where(:payment_type=>[1,2]).where(:status=>0).where(:warehouse_id=>User.find(session[:user_id]).warehouse_id).ids
    @suspense_advance=OutwardApproval.where(:outward_id=>@ids).pluck(:dispatch_date,:party_name,:outward_id)
   # @warehouse_id=Warehouse.pluck(:id)
   #byebug
  end  
  
  def location_approve
    Company.location_approve(params)     
    redirect_to :action=>"super_admin"
  end 

  def suspense_advance_approve
    Company.suspense_advance_approve(params)
    redirect_to :action=>"super_admin"
  end 

  def damage_date
    params[:from]
    to=Date.parse(params[:to])+1
    @to=to.strftime("%Y-%m-%d")
    redirect_to :action=>"super_admin",:from=>params[:from],:to=>@to
  end 
 def return_date
    params[:from]
    to=Date.parse(params[:to])+1
    @to=to.strftime("%Y-%m-%d")
    redirect_to :action=>"super_admin",:from=>params[:from],:to1=>@to
  end 


  def approve_reject_report
    params[:from]
    to=Date.parse(params[:to])+1
    @to=to.strftime("%Y-%m-%d")
    redirect_to :action=>"super_admin",:from=>params[:from],:to2=>@to
  end  
  
  def direct_sale
   params[:from]
    to=Date.parse(params[:to])+1
    @to=to.strftime("%Y-%m-%d")
    redirect_to :action=>"super_admin",:from=>params[:from],:to3=>@to  
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def company_params
      params.require(:company).permit(:company_name, :contact_id, :address_id, :isactive, :created_by, :updated_by,contact_attributes: [:email,:telephone_number, :mobile_number], address_attributes: [:address1, :post_code, :city, :state, :country])
    end
end
