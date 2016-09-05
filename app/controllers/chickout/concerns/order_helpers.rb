module Chickout::Concerns::OrderHelpers
  extend ActiveSupport::Concern

  def actualize_cart
    order = Chickout::OrderFiller.new(current_customers_order || Chickout::Order.new).
      add_items_to_order(read_from_cookies)
    cookies.delete('items') if order.persisted?
    # byebug
    order
  end
  
  def current_order
    current_customer ? Chickout::Order.current_order_of_customer(current_customer) : nil
  end

  def last_order
    current_order || (current_customer ? Chickout::Order.processing_by_customer(current_customer).last : nil)
  end

  def current_customers_order
    current_order || Chickout::Order.create_customers_order(current_customer)
  end

  def order_from_cookies
    order = Chickout::Order.new
    order.items = read_from_cookies
    order
  end

  private

    def get_order
      current_customers_order || Chickout::Order.new
    end
end