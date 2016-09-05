module Chickout
  module ApplicationHelper
    def route_index_helper(class_name)
      str = class_name.to_s.pluralize
      Rails.application.routes.url_helpers.send("#{str}_path")
    end

    def product_sym
      Chickout.product_class.name.downcase.to_sym
    end
  end
end
