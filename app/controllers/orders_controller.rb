class OrdersController < ApplicationController
	
	# GET /orders
	def index
		@orders = Order.all
		render json: @orders
	end
	

	#GET /orders/consult_status/
	def consult_status
		if params[:reference].blank? && params[:client_name].blank?
			render json: { message: "No search parameters sent" }, status: 400
		else
			@order = Order.filter_by_reference(params[:reference]) if params[:reference].present?
			@order = Order.filter_by_client_name(params[:client_name]).limit(10) if params[:client_name].present?

			render json: @order
		end
		
	end

	#GET /orders/consult_pipeline
	def consult_pipeline
		if params[:purchase_channel].blank? && params[:status].blank?
			render json: { message: "No search parameters sent" }, status: 400
		else
			if params[:purchase_channel].present? && params[:status].present?
				@orders = Order.filter_by_purchase_channel(params[:purchase_channel]).filter_by_status(params[:status])
			else 
				@orders = Order.filter_by_purchase_channel(params[:purchase_channel]) if params[:purchase_channel].present?
				@orders = Order.filter_by_status(params[:status]) if params[:status].present?
			end
		  
			render json: @orders
		end
	end
	
	# POST /orders
	def create
		@order = Order.new(order_params)

		if @order.save
			render json: @order, status: :created
		else
			render json: @order.errors, status: :unprocessable_entity
		end
	end
	
	
	private
	
		def order_params
			params.require(:order).permit(:reference, :purchase_channel, :client_name, :address, :delivery_service, :total_value, :line_items, :status)
		end
end
