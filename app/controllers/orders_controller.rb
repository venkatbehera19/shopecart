class OrdersController < ApplicationController

    def index 
        @orders = current_user.orders
    end

    def create 
        @test = calculate_total_amount_object;
        cart_items_for_user = current_user.cart_items
        invoice_number = rand(1000);
        new_record = current_user.orders.create(total_amount:calculate_total, invoice_number:invoice_number )
        if new_record 
            calculate_total_amount_object.each do |cart_item| 
                new_record.order_items.create( product_id: cart_item["product_id"],
                                               product_name: cart_item["product_name"],
                                               product_description: cart_item["product_description"],
                                               product_price: cart_item["product_price"],
                                               total_amount: cart_item["product_price"] * cart_item["quantity"]
                                              )
            end
            redirect_to orders_path
            current_user.cart_items.each do |cart_item|
                cart_item.destroy
            end
        end
    end

    private
        def calculate_total_amount_object
            @all_cart_items = [];
            cart_items = current_user.cart_items
            cart_items.each do |item|
                modifed_cart_items = {}
                modifed_cart_items["id"] = item.id;
                modifed_cart_items["product_id"] = item.product_id;
                modifed_cart_items["cart_id"] = item.cart_id;
                modifed_cart_items["quantity"] = item.quantity;
                product_detail = current_user.cart_products.find_by(id:item.product_id);
                modifed_cart_items["product_name"] = product_detail.name
                modifed_cart_items["product_price"] = product_detail.price
                modifed_cart_items["product_description"] = product_detail.description
                @all_cart_items << modifed_cart_items
            end
            @all_cart_items
        end

        def calculate_total 
            total_money = 0;
            calculate_total_amount_object.each do |all_cart_item|
                total_money += all_cart_item["product_price"] * all_cart_item["quantity"]
            end
            total_money
        end
end
