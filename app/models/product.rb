class Product < ApplicationRecord
    has_many   :cart_items, dependent: :delete_all
    has_many   :orders
    has_many   :order_items, dependent: :delete_all
    belongs_to :user
    has_many   :product_categories , dependent: :delete_all
    has_many   :categories ,through: :product_categories
end
