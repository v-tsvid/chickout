module PriceCalculator

  SHIPPING_METHOD_LIST ||= ["UPS Ground", 
                            "UPS One Day", 
                            "UPS Two Days"]

  def calc_shipping_price(method)
    case method
    when SHIPPING_METHOD_LIST[0] then 5.00
    when SHIPPING_METHOD_LIST[1] then 15.00
    when SHIPPING_METHOD_LIST[2] then 10.00
    else 0
    end
  end

  def calc_total_price
    (self.subtotal / 100 * (100 - discount) + self.shipping_price)
  end

  private

    def discount
      self.coupon ? self.coupon.discount : 0
    end

    def update_subtotal
      self.subtotal = self.items.collect { |item| item.price }.sum
    end

    def update_total_price
      self.total_price = self.calc_total_price
    end

    def update_shipping_price
      self.shipping_price = self.calc_shipping_price(self.shipping_method)
    end
end