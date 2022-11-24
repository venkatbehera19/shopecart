class UsersController < ApplicationController

    def new 
        @user = User.new
    end

    def create 
        @user = User.new(user_params);
        respond_to do |format|
            if @user.save
                create_cart = @user.build_cart
                if create_cart.save
                    format.html { redirect_to root_path, :flash => { :success => "User Created Successfully" } }
                else  
                    format.html { redirect_to root_path, :flash => { :success => "Something went wrong" } }
                end
            else 
                format.html { render :new, status: :unprocessable_entity }
            end
        end
    end

    private 
        def user_params 
            # strong parameters
            params.require(:user).permit(:email, :name, :phone, :password, :password_confirmation)
        end
end
