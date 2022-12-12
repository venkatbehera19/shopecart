class Product < ApplicationRecord
    validates  :category_id, presence:true
    has_many   :cart_items
    has_many   :orders
    has_many   :order_items
    belongs_to :user
    belongs_to :category
end
