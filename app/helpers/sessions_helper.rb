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

    def add_cart_to_sessions(data) 
        if !is_cart_sessions?
            session_cart_element = [];
            session_cart_element << data;
            session[:cart] = session_cart_element
        else
            test = is_item_present_in_sessions(data);
            if !is_item_present_in_sessions(data)
                ele_sessions = cart_sessions;
                ele_sessions << data;
                session[:cart] = ele_sessions;
            end
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
end
