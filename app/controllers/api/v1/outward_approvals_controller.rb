module Api
  module V1
    class OutwardApprovalsController < ApplicationController
      skip_before_action :verify_authenticity_token
        skip_before_action :check_session
    #  skip_power_check
     # skip_before_filter :authenticate


      respond_to :json

      def index
        respond_with OutwardApproval.all
      end

      def show
        respond_with OutwardApproval.find(params[:id])
      end

      def create
        respond_with :api, :v1, OutwardApproval.create(outward_approval_params)
      end

      def update
        respond_with OutwardApproval.update(outward_approval_params)
      end
      
      def outward_id
       @out=Outward.find(params[:outward_id])
       @outward_id=OutwardApproval.find_by(:outward_id=>params[:outward_id])

       respond_to do |format|
       format.json  { render :json => {:outward=> @out, 
                                  :outward_approval => @outward_id }}
      end
      
       end  

      def destroy
        respond_with OutwardApproval.destroy(params[:id])
      end

      private

      def outward_approval_params
        params.require(:outward_approval).permit!
      end

    end
  end
end
