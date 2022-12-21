class RolesController < ApplicationController

    def index  
        @roles = Role.all 
    end

    def new 
        @role = Role.new
    end

    def create
        @role = Role.new(roles_params);
        respond_to do |format|
            if @role.save
                format.js
            else 
                format.js
            end
        end
    end

    def edit 
        @role = Role.find_by(id: params[:id])
    end

    def update 
        @role = Role.find_by(id: params[:id]);
        respond_to do |format|
            if @role.update(roles_params)
                format.js
            end
        end
    end

    def destroy 
        @role = Role.find_by(id: params[:id]);
        @role.destroy
        respond_to do |format| 
            format.js
        end
    end

    private 
        def roles_params 
            params.require(:role).permit(:name)
        end
end
