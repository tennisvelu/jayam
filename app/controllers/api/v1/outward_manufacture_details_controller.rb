module Api
  module V1
    class OutwardManufactureDetailsController < ApplicationController
      skip_before_action :verify_authenticity_token
      skip_before_action :check_session
#      skip_power_check
#      skip_before_filter :authenticate


      respond_to :json

      def index
        respond_with OutwardManufactureDetail.all
      end

     def show
        respond_with OutwardManufactureDetail.find(params[:id])
     end

     def create
       params.permit!
       @outward=OutwardManufactureDetail.create(params["_json"])
       @outward_id=params["_json"][0][:outward_id]
       @type_of_load=Outward.find(@outward_id).type_of_load
       @payment_type=Outward.find(@outward_id).payment_type
       @warehouse_id=Outward.find(@outward_id).warehouse_id 
       @count=params["_json"].count
        if @payment_type==0
         if LoadingType.find(@type_of_load).type_of_loading=="Damage"
           (0..@count-1).map do |i|
           grade=@outward[i].grading
           damage=Damage.where(:warehouse_id=>@warehouse_id).last
           total=damage.total_quantity
           quantity=total-@outward[i].quantity
           damage.update(:total_quantity=>quantity)
         end
        end
        #else
        unless LoadingType.find(@type_of_load).type_of_loading=="Damage"
         (0..@count-1).map do |i|
           grade=@outward[i].grading
           stock=Stock.find_by(:grade_id=>grade,:warehouse_id=>@warehouse_id)
           book=stock.book_stock
           physical=stock.physical_stock
           stock.update(:book_stock=>book-@outward[i].quantity,:physical_stock=>physical-@outward[i].quantity)
         end
        end
      end
      render json: @outward
    end

    def outward_id_detail
     unless params[:outward_id].nil?
     @outward_id=OutwardManufactureDetail.where(:outward_id=>params[:outward_id])
     render json: @outward_id
     end
    end  

   def outward_manufacture_detail
      detail=OutwardManufactureDetail.where(:outward_id=>params[:outward_id])
      render json: detail

    end 

      def update
        respond_with OutwardManufactureDetail.update(outward_manufacture_detail_params)
      end

      def destroy
        respond_with OutwardManufactureDetail.destroy(params[:id])
      end

      private

      def outward_manufacture_detail_params
        params.permit!
      end

    end
  end
end

