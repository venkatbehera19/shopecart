module CartItemsHelper
    def cart_total_money(all_cart_items = [])
        total_money = 0
        all_cart_items.each do |all_cart_item|
            total_money += all_cart_item.product.price * all_cart_item["quantity"]
        end
        total_money
    end
    
    def session_cart(cart)
        total_money = 0
        cart.each do |all_cart_item|
            total_money += all_cart_item['price'].to_i * all_cart_item["quantity"].to_i
        end
        total_money
    end
end
