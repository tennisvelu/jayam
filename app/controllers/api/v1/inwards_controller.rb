module Api
  module V1
    class InwardsController < ApplicationController
      skip_before_action :verify_authenticity_token
        skip_before_action :check_session
#      skip_power_check
#      skip_before_filter :authenticate


      respond_to :json

      def index
        respond_with Inward.all
      end

      def show
        respond_with Inward.find(params[:id])
      end

      def create
       inward=Inward.create(inward_params)
       render json: inward
      end

      
      def warehouse_identification
        @warehouse_id_api=Inward.where(:warehouse_id=>params[:format].to_i)
        render json: @warehouse_id_api
      end 
      
      def inward_identification
        @inward_id_api=InwardManufactureDetail.where(:inward_id=>params[:format].to_i)
        render json: @inward_id_api
      end 
      
      def update
        @total=Inward.find(params[:id]).update(:total_quantity=>params[:total_quantity])
        render json:@total
      end
      
      def total_quantity_update
        @total=Inward.find(params[:id]).update(:total_quantity=>params[:total_quantity],:warehouse_id=>params[:warehouse_id])
        render json:@total
        end 
     
      def destroy
        respond_with Inward.destroy(params[:id])
      end

      private

      def inward_params

        params.require(:inward).permit!
      end

    end
  end
end

