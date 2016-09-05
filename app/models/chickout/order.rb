module Chickout
  class Order < ActiveRecord::Base
    include AASM
    include PriceCalculator

    STATE_LIST = ["in_progress", 
                  "processing", 
                  "shipping", 
                  "completed", 
                  "canceled"]

    belongs_to :customer, class_name: Chickout.customer_class.to_s, foreign_key: 'customer_id'
    belongs_to :credit_card, class_name: Chickout.credit_card_class.to_s, foreign_key: 'credit_card_id'
    belongs_to :billing_address, class_name: Chickout.address_class.to_s, foreign_key: 'billing_address_id'
    belongs_to :shipping_address, class_name: Chickout.address_class.to_s, foreign_key: 'shipping_address_id'
    belongs_to :coupon
    has_many :items, dependent: :delete_all

    scope :processing_by_customer, -> customer { 
      where(customer: customer, state: 'processing') }

    aasm column: 'state', whiny_transitions: false do 
      state :in_progress, initial: true
      state :processing
      state :shipping 
      state :completed 
      state :canceled

      event :process do
        transitions from: :in_progress, to: :processing
      end

      event :ship do
        transitions from: :processing, to: :shipping
      end

      event :complete do
        transitions from: [:processing, :shipping], to: :completed
      end

      event :cancel do
        transitions from: [:processing, :shipping], to: :canceled
      end
    end

    class << self
      def create_customers_order(customer)
        customer ? create(customer_id: customer.id, state: 'in_progress') : nil
      end

      def current_order_of_customer(customer)
        find_by(customer: customer, state: 'in_progress')
      end
    end

    def state_enum
      STATE_LIST
    end

    def custom_label_method
      self.decorate.number
    end

    def prepare_for_checkout(coupon_code)
      coupon = Coupon.find_by(code: coupon_code)
      next_step = self.next_step || 'address'
      
      self.update(coupon: coupon, next_step: next_step)
      self
    end
  end
end