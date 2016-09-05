module Chickout
  class ApplicationController < ::ApplicationController
    include Chickout::Concerns::CookiesHandling
    include Chickout::Concerns::OrderHelpers

    protect_from_forgery with: :exception

    helper_method :current_order#, :order_from_cookies
  end
end
