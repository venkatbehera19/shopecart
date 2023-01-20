class User < ApplicationRecord
  has_one  :cart, dependent:    :destroy
  has_many :cart_items, through: :cart
  has_many :cart_products, through: :cart_items, source: :product
  has_many :orders, dependent: :destroy
  has_many :order_items, through: :orders
  has_many :products
  has_many :invoices
  has_many :addresses
  belongs_to :role

  pay_customer stripe_attributes: :stripe_attributes
  
  before_save { email.downcase! }
  VALID_EMAIL_REGEX = /\A[^@][\w.-]+@[\w.-]+[.][a-z]{2,4}\z/i
  validates :email,    uniqueness: true,format: { with: VALID_EMAIL_REGEX }
  validates :name,     length: {minimum:3, maximum:20}
  validates :phone,    length: {minimum:10, maximum:10}
  validates :password, presence: true, length: { minimum:6, maximum:12}, allow_nil: true
  attribute :role_id, :default => 1    
  # vertual attributes for auth
  has_secure_password 

  def stripe_attributes(pay_customer){
    address: {
        # city: pay_customer.owner.city,
        city: '',
        # country: pay_customer.owner.country,
        country: ''
    },
    metadata: {
        pay_customer_id: pay_customer.id,
        user_id: id
    }
  }
  end
end