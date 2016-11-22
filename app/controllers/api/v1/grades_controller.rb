module Api
  module V1
    class GradesController < ApplicationController
        skip_before_action :verify_authenticity_token
        skip_before_action :check_session
#      skip_power_check
#      skip_before_filter :authenticate

      respond_to :json

      def index
        respond_with Grade.all
      end

      def show
        respond_with Grade.find(params[:id])
      end

      def create
        respond_with :api, :v1, Grade.create(grade_params)
      end

      def update
        respond_with Grade.update(grade_params)
      end

      def destroy
        respond_with Grade.destroy(params[:id])
      end

      private

      def grade_params
        params.require(:grade).permit!
      end

    end
  end
end


