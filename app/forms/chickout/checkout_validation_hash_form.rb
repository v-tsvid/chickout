module Chickout
  class CheckoutValidationHashForm
  
    attr_reader :validation_hash
    attr_reader :return_hash
    
    def initialize(model, params, steps, step, next_step, is_next)
      @model = model
      @params = params
      @steps = steps
      @step = step
      @next_step = next_step
      @is_next = is_next
      
      self.validation_hash = init_validation_hash
      self.return_hash = init_return_hash
    end

    private

      attr_writer :validation_hash
      attr_writer :return_hash
      
      def init_validation_hash
        val_hash_initial.merge(val_hash_with_step)
      end

      def val_hash_initial
        if @steps[0..2].include?(@step)
          set_next_step.merge(@params['model']) 
        else
          set_next_step
        end
      end

      def val_hash_with_step
        case @step
        when :address then address_for_val_hash
        when :confirm then {'state' => "processing"}
        else {}
        end
      end

      def address_for_val_hash
        if @params['use_billing']
          {'shipping_address' => @params['model']['billing_address']} 
        else
          {}
        end
      end

      def init_return_hash
        case @step
        when :address then addresses_for_return_hash
        when :shipment then shipping_for_return_hash
        when :payment then validation_hash['credit_card']
        else {}
        end
      end

      def addresses_for_return_hash
        { 'billing_address' => validation_hash['billing_address'], 
          'shipping_address' => validation_hash[billing_or_shipping] }
      end

      def billing_or_shipping
        @params['use_billing'] ? 'billing_address' : 'shipping_address'
      end

      def shipping_for_return_hash
        { 'shipping_method' => @params['model']['shipping_method'],
          'shipping_price' => @params['model']['shipping_price']} 
      end

      def set_next_step
        val_hash = @model.attributes
        val_hash.merge!({next_step: @next_step.to_s}) if @is_next
        val_hash
      end
  end
end