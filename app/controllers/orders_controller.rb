class OrdersController < ApplicationController
	before_action :set_order, only: [:show, :update] #, :destroy]

	# GET /orders
	def index
		@orders = Order.all
		render json: @orders
	end
	
	# GET /orders/1
	def show
		render json: @order
	end

	#GET /orders/consult_status/
	def consult_status
		@order = Order.filter_by_reference(params[:reference]) if params[:reference].present?
		@order = Order.filter_by_client_name(params[:client_name]) if params[:client_name].present?
		render json: @order
	end

	#GET /orders/consult_purchase_channel
	def consult_purchase_channel
		@orders = Order.filter_by_purchase_channel(params[:purchase_channel]).filter_by_status("ready") if params[:purchase_channel].present?
		render json: @orders
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
	
	# PATCH/PUT /orders/1
	def update
		if @order.update(order_params)
			render json: @order
		else
			render json: @order.errors, status: :unprocessable_entity
		end
	end
	
	# DELETE /orders/1
	# def destroy
	# 	@order.destroy
	# end
	
	private
		# Use callbacks to share common setup or constraints between actions.
		def set_order
			@order = Order.find(params[:id])
		end
	
		# Only allow a trusted parameter "white list" through.
		def order_params
			params.require(:order).permit(:reference, :purchase_channel, :client_name, :address, :delivery_service, :total_value, :line_items, :status)
		end
end
