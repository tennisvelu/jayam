module Api
  module V1
    class OutwardsController < ApplicationController
      skip_before_action :verify_authenticity_token
        skip_before_action :check_session
#      skip_power_check
#      skip_before_filter :authenticate


      respond_to :json

      def index
        respond_with Outward.all
      end

      def show
        respond_with Outward.find(params[:id])
      end

      def create
      @outward_detail=Outward.create(outward_params)
      @inward_detail=Inward.where("DATE(inward_date) = ?", @outward_detail.outward_date.to_date).where(:truck_number=>@outward_detail.truck_number)
      unless @inward_detail.empty?
       @outward_detail.update(:status=>5)
      end
      render json: @outward_detail
      end

      def update
        respond_with Outward.update(outward_params)
      end

      def destroy
        respond_with Outward.destroy(params[:id])
      end

      def total_quantity_update
        @total=Outward.find(params[:id]).update(:total_quantity=>params[:total_quantity],:warehouse_id=>params[:warehouse_id])
        render json:@total
      end 

      private

      def outward_params
        params.require(:outward).permit!
      end

    end
  end
end