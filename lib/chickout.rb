require "chickout/engine"

module Chickout
  mattr_accessor :customer_class
  mattr_accessor :credit_card_class
  mattr_accessor :address_class
  mattr_accessor :product_class

  class << self
    [:customer, :address, :credit_card, :product].each do |item|
      item_class = "#{item}_class"
      
      define_method item_class.to_sym do
        class_variable_get("@@#{item_class}".to_sym).try(:constantize)
      end
    end
  end
end
