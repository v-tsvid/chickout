module Chickout
  class PriceDecorator < Draper::Decorator
   
    def price
      object ? "$#{'%.2f' % object}" : nil
    end
  end
end