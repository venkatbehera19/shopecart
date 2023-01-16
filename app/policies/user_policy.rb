class UserPolicy < ApplicationPolicy
  # attr_reader :user

  # def initialize(user)
  #   @user = user
  # end

  def is_admin? 
    user.name.role.name == 'admin'
  end

  def update? 
    user.id == record.id
  end

  def destory? 
    is_admin?
  end

  def index?
    is_admin?
  end

end