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
       @outward_params=OutwardManufactureDetail.create(outward_manufacture_detail_params["_json"])
       render json: @outward_params
    end

    def outward_id_detail
    unless params[:outward_id].nil?
    @outward_id=OutwardManufactureDetail.where(:outward_id=>params[:outward_id])
    render json: @outward_id
  end
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

