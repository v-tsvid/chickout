module Chickout
  class CouponForm< Reform::Form
    model :coupon

    property :code
    property :discount

    validates :code, :discount, presence: true
    validates :discount, inclusion: { in: 1..99 }
  end
end