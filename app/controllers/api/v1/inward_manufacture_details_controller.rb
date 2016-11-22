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
        respond_with :api, :v1, InwardManufactureDetail.create(inward_manufacture_detail_params)
       end

      def update
        respond_with InwardManufactureDetail.update(inward_manufacture_detail_params)
      end

      def destroy
        respond_with InwardManufactureDetail.destroy(params[:id])
      end

      private

      def inward_manufacture_detail_params
       params.require(:inward_manufacture_detail).permit!
      end
    end
  end
end

