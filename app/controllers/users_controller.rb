class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]

  def index 
    @users = User.all
  end

  def new 
    @user = User.new
  end

  def create 
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        UserMailer.with(user: @user).welcome_email.deliver_now
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

    def show 
      @user = current_user
      @orders = current_user.orders
      @my_products = current_user.products
    end

    def edit 
      @user = User.find(params[:id])
    end

    def update 
      @user = User.find(params[:id])
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to user_url(@user), :flash => { :success => "Profile Updated Successfully."}}
          format.js
        else
          format.js
          format.html { render :edit, status: :unprocessable_entity}
        end
      end
    end

    def destroy 
      @user = User.find_by(id: params[:id])
      respond_to do |format|
        if @user.destroy 
          format.js
        end
      end
    end

    private 
      def user_params 
        params.require(:user).permit(:email, :name, :phone, :password, :password_confirmation, :role_id)
      end

      def logged_in_user 
        unless log_in?
          flash[:danger] = "please log in"
          redirect_to login_url
        end
      end
end
