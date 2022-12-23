class Role < ApplicationRecord
    has_many :user
    validates :name, presence: true, uniqueness: true
end
# Product.joins(:categories).where("products.name LIKE :query", query: "%#{params[:query]}%").where( categories: {id: params[:category_id].to_i})