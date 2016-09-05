require_dependency "chickout/application_controller"

module Chickout
  class ItemsController < ApplicationController

    # authorize_resource

    def index
      @order = actualize_cart
      @items = @order.items
      return unless @items.empty?
      
      @order.destroy
      redirect_to main_app.root_url, notice: t("controllers.cart_is_empty") 
    end

    def create
      if current_customer
        items = [Chickout::Item.item_from_params(item_params)]
        @order = OrderFiller.new(current_customers_order).add_items_to_order items
      else
        interact_with_cookies { |items| push_to_cookies(items) }
      end
      redirect_to :back, notice: "\"#{Chickout.product_class.title_by_id(params[:product_id])}\" "\
                                 "#{t("controllers.added")}"
    end

    def destroy
      @item = Chickout::Item.find_by_id(params[:id])
      if @item
        @item.destroy
        current_order.destroy unless current_order.items[0]  
        notice = "\"#{@item.product.title}\" #{t("controllers.removed")}"
      else
        notice = t("controllers.failed_to_remove_product")
      end
      redirect_to :back, notice: notice
    end

    def delete_from_cookies
      interact_with_cookies { |items| pop_from_cookies(items) }
      redirect_to :back, notice: "\"#{Chickout.product_class.title_by_id(params[:product_id])}\" "\
                                 "#{t("controllers.removed")}"
    end

    private
      def item_params
        params.permit(:product_id, :quantity)
      end
  end
end
