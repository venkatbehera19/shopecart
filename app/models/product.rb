class Product < ApplicationRecord
    has_many :cart_items
    has_many :orders
    has_many :order_items
    belongs_to :user
end
