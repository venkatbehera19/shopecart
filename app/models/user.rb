class User < ApplicationRecord
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
