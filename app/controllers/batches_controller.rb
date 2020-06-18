class BatchesController < ApplicationController

	# POST /batches
	def create
		@batch = Batch.new(batch_params)

		begin 
			ActiveRecord::Base.transaction do
				if Batch.validate_batch_orders(params[:group_orders])
					if @batch.save
						Order.update_status_by_batch(self.group_orders,"production")
						render json: @batch, status: :created
					end
				end		
			end
		rescue
			render json: "Error creating batch", status: 422
		end
	end

	private
		# Use callbacks to share common setup or constraints between actions.
		def set_batch
			@batch = Batch.find(params[:id])
		end
	
		# Only allow a trusted parameter "white list" through.
		def batch_params
			params.require(:batch).permit(:reference, :purchase_channel, :group_orders)
		end
end
