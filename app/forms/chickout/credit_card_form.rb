module Chickout
  class CreditCardForm< Reform::Form
    model :credit_card
    
    VALID_EXP_MONTH_REGEX = /\A([0][1-9]|[1][0-2])\z/
    VALID_EXP_YEAR_REGEX = /\A[2][0]([1][5-9]|[2][0-9])\z/
    VALID_CVV_REGEX = /\A[0-9]{3,4}\z/

    INVALID_MESSAGE = "is not valid"
    EXPIRED_MESSAGE = "is expired"

    property :firstname
    property :lastname
    property :number
    property :cvv
    property :expiration_month
    property :expiration_year
    property :customer_id

    validates :number, 
              :cvv, 
              :firstname, 
              :lastname,
              :expiration_month, 
              :expiration_year, 
              :customer_id,
              presence: true

    validates :expiration_month, format: { with: VALID_EXP_MONTH_REGEX, 
      message: INVALID_MESSAGE }
    validates :expiration_year, format: { with: VALID_EXP_YEAR_REGEX, 
      message: INVALID_MESSAGE }
    validates :cvv, format: { with: VALID_CVV_REGEX, message: INVALID_MESSAGE }

    validate :validate_number, :validate_exp_date

    private

      def validate_number
        # CreditCardValidator::Validator.valid? 
        # is provided by credit_card_validator gem
        number = self.number
        errors.add(:credit_card, INVALID_MESSAGE) unless 
          number && CreditCardValidator::Validator.valid?(number)
      end

      def validate_exp_date
        errors[:base] << EXPIRED_MESSAGE unless is_date_correct?   
      end

      def is_date_correct?
        self.expiration_month && self.expiration_year && 
        (is_year_greater? || is_year_equal? && is_month_greater_or_equal?)
      end

      def is_month_greater_or_equal?
        today_month = Date.today.strftime("%m")
        self.expiration_month >= today_month
      end

      def is_year_greater?
        is_year_correct?(:>)
      end

      def is_year_equal?
        is_year_correct?(:==)
      end

      def is_year_correct?(sym)
        today_year = Date.today.strftime("%Y")
        self.expiration_year.public_send(sym, today_year)
      end
  end
end