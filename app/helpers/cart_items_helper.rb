module CartItemsHelper
    def cart_total_money(all_cart_items = [])
        total_money = 0
        all_cart_items.each do |all_cart_item|
            total_money += all_cart_item.product.price * all_cart_item["quantity"]
        end
        total_money
    end

    def find_product(id)
        Product.find_by(id: id);
    end
    
    def session_cart (cart)
        total_money = 0
        cart.each do |all_cart_item|
            total_money += find_product(all_cart_item['id']).price * all_cart_item["quantity"]
        end
        total_money
    end
end
