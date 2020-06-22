class BatchesController < ApplicationController
	before_action :set_batch, only: [:update_status]

	# POST /batches
	def create
		@batch = Batch.new(batch_params)
		@batch.group_orders = params[:group_orders].to_s
	
		begin 
			ActiveRecord::Base.transaction do
				if Batch.check_batch_orders(params[:group_orders], params[:purchase_channel])
					if @batch.save
						count_orders = Order.update_status_by_batch(params[:group_orders],"production")
						render json: {reference: @batch.reference, count_orders: count_orders}, status: :created
					end
				else
					render json: {message: "Selected orders do not have the same publishing channel"}, status: 400
				end	
			end
		rescue
			render json:  {message: "Error creating batch"}, status: :unprocessable_entity
		end
	end

	#PUT /batches/update_status/:id
	def update_status
		begin 
			ActiveRecord::Base.transaction do
				count_orders = Order.update_status_by_batch(JSON.parse(@batch.group_orders), params[:status])
				render json: {reference: @batch.reference, count_orders: count_orders} 
			end
		rescue
			render json:  { message: "Error updating batch status" }, status: :unprocessable_entity
		end
	end

	private
		
		def set_batch
			@batch = Batch.find(params[:id])
		end
	
		def batch_params
			params.require(:batch).permit(:reference, :purchase_channel, :group_orders)
		end
end
