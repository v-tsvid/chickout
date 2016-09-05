module Chickout
  class OrderFiller
    def initialize(order)
      @order = order
    end

    def add_items_to_order(items_to_add)
      @order.items = Item.combine_items(
        @order.items, items_to_add)

      @order
    end
  end
end