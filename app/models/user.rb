class User < ApplicationRecord
    has_one :cart, dependent:    :destroy
    has_many :cart_items, through: :cart
    has_many :cart_products, through: :cart_items, source: :product
    has_many :orders, dependent: :destroy
    before_save { email.downcase! }
    # vertual attributes for auth
    has_secure_password 
    # Email validation
    VALID_EMAIL_REGEX = /\A[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}\z/i
    validates :email, presence: true, uniqueness: true,
                      format: { with: VALID_EMAIL_REGEX, message: "Invalid Email" }
    
    validates :name, presence: true, length: {minimum:3, maximum:20}
    validates :phone, presence: true, length: {minimum:10, maximum:10}
end
