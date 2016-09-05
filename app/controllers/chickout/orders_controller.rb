require_dependency "chickout/application_controller"

module Chickout
  class OrdersController < ApplicationController
    def index
      @orders = Chickout::Order.all
    end

    def show
      @order = Chickout::Order.find_by_id(params[:order_id])
    end

    def update
      current_order.items.destroy_all
      items = Chickout::Item.items_from_order_params order_params
      @order = Chickout::OrderFiller.new(current_order).add_items_to_order items

      @items = @order.items
    
      redirect_to cart_path, notice: t("controllers.updated")
    end

    def update_cookies
      @items = Chickout::Item.items_from_order_params order_params
      write_to_cookies @items 

      redirect_to cart_path, notice: t("controllers.updated")
    end

    def destroy
      @order = current_order
      @order.destroy

      redirect_to cart_path
    end

    def destroy_cookies
      cookies.delete('items')

      redirect_to cart_path
    end

    private

      def order_params
        params.permit(items_attrs: [:product_id, :quantity])
      end
  end
end