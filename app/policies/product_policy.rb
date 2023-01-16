class ProductPolicy < ApplicationPolicy
  attr_reader :user, :product

  def initialize(user, product)
    @user = user 
    @product = product 
  end

  def create? 
  end

end