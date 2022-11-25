module CartItemsHelper
    def cart_total_money(all_cart_items = [])
        total_money = 0
        all_cart_items.each do |all_cart_item|
            total_money += all_cart_item["product_price"] * all_cart_item["quantity"]
        end
        total_money
    end
end
