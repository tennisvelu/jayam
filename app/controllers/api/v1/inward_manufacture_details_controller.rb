module Api
  module V1
    class InwardManufactureDetailsController < ApplicationController
      skip_before_action :verify_authenticity_token
        skip_before_action :check_session
#      skip_power_check
#      skip_before_filter :authenticate


      respond_to :json

      def index
        respond_with InwardManufactureDetail.all
      end

      def show
        respond_with InwardManufactureDetail.find(params[:id])
      end

      def create
        params.permit!
        inward_manufacture=InwardManufactureDetail.create(params[:inward_manufacture_detail])
        inward_id=inward_manufacture.inward_id
        warehouse_id=Inward.find(inward_id).warehouse_id
        stock=Stock.find_by(:warehouse_id=>warehouse_id,:grade_id=>inward_manufacture.grading)
        book=stock.book_stock+inward_manufacture.quantity
        physical=stock.physical_stock+inward_manufacture.quantity
        stock.update(:book_stock=>book,:physical_stock=>physical)
        render json: inward_manufacture
      end

      def bulk_create
        params.permit!
        count=params["_json"].count
        inward_manufacture=InwardManufactureDetail.create(params["_json"])
        inward_id=inward_manufacture.pluck(:inward_id)[0]
        @warehouse_id=Inward.find(inward_id).warehouse_id
        @grade=inward_manufacture.pluck(:grading)
        count=@grade.count
        @quantity=inward_manufacture.pluck(:quantity)
        (0..count-1).map do |i|
        stock=Stock.find_by(:warehouse_id=>@warehouse_id,:grade_id=>@grade[i])
        book=stock.book_stock+@quantity[i]
        physical=stock.physical_stock+@quantity[i]
        stock.update(:book_stock=>book,:physical_stock=>physical)
        end
       render json: inward_manufacture
      end
      

      def update
        respond_with InwardManufactureDetail.update(inward_manufacture_detail_params)
      end

      def destroy
        respond_with InwardManufactureDetail.destroy(params[:id])
      end

      private

      def inward_manufacture_detail_params
        params.permit!
       #params.require(:inward_manufacture_detail).permit!
      end
    end
  end
end

