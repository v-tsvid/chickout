module Chickout
  class ItemForm< Reform::Form
    model :item

    property :price
    property :quantity
    property :product 
    property :order

    validates :price, :quantity, :product, presence: true
    validates :order, presence: true
    validates :price, numericality: { greater_than: 0 }
    validates :quantity, numericality: { only_integer: true,
                                         greater_than: 0 }
  end
end