module Chickout::Concerns::CookiesHandling
  extend ActiveSupport::Concern
  
  private
    def interact_with_cookies
      items = Chickout::Item.compact_items(read_from_cookies)
      yield items
      write_to_cookies(items)
    end

    def push_to_cookies(items)
      items << Chickout::Item.new(product_id: params[:product_id], 
                                   quantity: params[:quantity])
    end

    def pop_from_cookies(items)
      items.each do |item|
        items.delete(item) if item.product_id.to_s == params[:product_id]
      end
    end

    def write_to_cookies(items)
      str = ''
      items.each do |item|
        str = [str, item[:product_id], item[:quantity]].join(' ')
      end
      
      cookies[:items] = {value: str, expires: 30.days.from_now}
    end

    def read_from_cookies
      items = Array.new
      if cookies[:items]
        pairs_of_numbers(cookies[:items]).each do |item|
          items << Chickout::Item.new(product_id: item[0], quantity: item[1])
        end
      end
      items
    end

    def pairs_of_numbers(str)
      str.split(' ').partition.with_index{ |v, index| index.even? }.transpose
    end
end