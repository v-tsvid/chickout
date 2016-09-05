module Chickout
  class Item < ActiveRecord::Base
    before_validation :update_price

    validates :price, :quantity, presence: true
    validates :price, numericality: { greater_than: 0 }
    validates :quantity, numericality: { only_integer: true,
                                         greater_than_or_equal_to: 0 }

    belongs_to :product, class_name: Chickout.product_class.to_s, foreign_key: 'product_id'
    belongs_to :order

    def custom_label_method
      "order #{order_id}, product #{product_id}, #{quantity} pcs"
    end

    class << self

      def item_from_params(params)
        new(product_id: params[:product_id], quantity: params[:quantity])
      end

      def items_from_order_params(order_params)
        order_params[:items_attrs].map do |params|
          item_from_params(params)
        end
      end

      def combine_items(items, items_to_add)
        temp_items = items.map { |item| Item.new(item.attributes) }
        items = Chickout::Item.compact_items(temp_items + items_to_add)

        items
      end

      def compact_items(items)
        items = grouped(items).map do |item| 
          Chickout::Item.new(product_id: item.first.product_id, 
                        quantity: total_quantity(item))
        end
        get_prices_from_products(items)
      end

      private 

        def grouped(items)
          items.group_by{|gr_item| gr_item.product_id}.values
        end

        def total_quantity(item)
          item.inject(0){|sum, inj| sum + inj.quantity}
        end

        def get_prices_from_products(items)
          items.each do |item|
            # byebug
            item.price = item.product.price * item.quantity
          end
        end
    end

    private

      def update_price
        self.price = self.product.price * self.quantity
      end
  end
end
