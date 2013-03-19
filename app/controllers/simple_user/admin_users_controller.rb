module SimpleUser
  class AdminUsersController < ApplicationController

    layout ENV['ADMIN_LAYOUT']

    before_filter :authenticate_admin_user!
    before_filter :authorize_admin_user_manager

    def index
      @admin_users = AdminUser.get_editable_admins_except(current_admin_user.id)

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @admin_users }
      end
    end

    def show
      @admin_user = AdminUser.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @admin_user }
      end
    end

    def new
      @admin_user = AdminUser.new
      @required_password = true

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @admin_user }
      end
    end

    def edit
      @admin_user = AdminUser.find(params[:id])

      if @admin_user.has_role? :admin
        flash[:error] = "Access denied"
        redirect_to root_url
      end

      @admin_user.get_roles
      @required_password = false
    end

    def create
      @admin_user = AdminUser.new(params[:admin_user])
      @required_password = true

      roles = []
      if can? :manage, Role
        roles = params[:admin_user][:temporal_roles].split(",")
      end
      params[:admin_user].delete(:temporal_roles)

      respond_to do |format|
        if @admin_user.save
          if can? :manage, Role
            roles.map{ |role|
              @admin_user.add_role role.strip
            }
          end

          format.html { redirect_to @admin_user, notice: 'Admin was successfully created.' }
          format.json { render json: @admin_user, status: :created, location: @admin_user }
        else
          format.html { render action: "new" }
          format.json { render json: @admin_user.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      @admin_user = AdminUser.find(params[:id])
      @required_password = false

      if @admin_user.has_role? :admin
        flash[:error] = "Access denied"
        redirect_to root_url
      end

      roles = []
      if can? :manage, Role
        roles = params[:admin_user][:temporal_roles].split(",")
      end
      params[:admin_user].delete(:temporal_roles)

      if params[:admin_user][:password].blank?
        params[:admin_user].delete(:password)
        params[:admin_user].delete(:password_confirmation)
      end

      respond_to do |format|
        if @admin_user.update_attributes(params[:admin_user])
          if can? :manage, Role
            @admin_user.roles.destroy_all

            roles.map{ |role|
              @admin_user.add_role role.strip
            }
          end

          format.html { redirect_to @admin_user, notice: 'Admin was successfully updated.' }
          format.json { head :no_content }
        else
          @admin_user.get_roles
          format.html { render action: "edit" }
          format.json { render json: @admin_user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @admin_user = AdminUser.find(params[:id])
      @admin_user.destroy

      respond_to do |format|
        format.html { redirect_to admin_users_url }
        format.json { head :no_content }
      end
    end

    def authorize_admin_user_manager
      if !can? :manage, AdminUser
        flash[:error] = "Access denied"
        redirect_to root_url
      end
    end

  end
end
