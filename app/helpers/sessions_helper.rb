module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user 
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def log_in?
    !current_user.nil?
  end

  def log_out 
    session.delete(:user_id);
    @current_user = nil
  end

  def total_cart_items
    total_items_length = current_user ? current_user.cart_items.length : 0
  end

  def cart_sessions 
    if session[:cart]
      @session_cart = session[:cart]
    end
  end

  def cart_sessions_clear 
    session[:cart] = nil
  end

  def is_cart_sessions? 
    !cart_sessions.nil?
  end

  def is_item_present_in_sessions (data)
    cart_sessions.each do |item|
      if item["id"] == data[:id]
        return true;
      end
    end
    return false;
  end

  def get_session_element(id)
    cart_sessions.each do |item| 
      if item["id"] == id 
        return item
      end
    end
    return {}
  end

  def remove_session_element(id)
    cart_sessions.delete_if { |cart_session| cart_session["id"] == id.to_s }
    session[:cart] = cart_sessions
    cart_sessions
  end

  def update_session_element(data)
    cart_sessions.each do |item| 
      if item["id"] == data[:id] 
        item["quantity"] = data[:quantity]
        item["price"] = data[:price].to_i
      end
    end
    cart_sessions
  end

  def add_cart_to_sessions(data) 
    if is_cart_sessions?
      test = is_item_present_in_sessions(data);
      if !is_item_present_in_sessions(data)
        session[:cart] << data;
      end
    else
      session_cart_element = [];
      session_cart_element << data;
      session[:cart] = session_cart_element
    end
  end

  def is_session_cart_present_in_user_cart ( user_cart,session_cart)
    return user_cart.find_by(product_id:session_cart["id"])
  end

  def cart_or_sessions 
    if log_in?
      return total_cart_items
    else 
      if cart_sessions
        return cart_sessions.length
      else
        return 0
      end
    end
  end

  def is_admin? 
    if current_user
      current_user.role_id == 2 ? true : false
    else 
      return false
    end
  end

  def role(role_id) 
    name = Role.find_by(id: role_id);
    return name.name
  end
end
