module SimpleUser
  class UsersController < ApplicationController
    
    before_filter :authenticate_admin_user!
    before_filter :authorize_user_manager

    def index
      @users = User.all

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @users }
      end
    end

    def show
      @user = User.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    end

    def new
      @user = User.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @user }
      end
    end

    def edit
      @user = User.find(params[:id])
    end

    def create
      @user = User.new(params[:user])

      respond_to do |format|
        if @user.save
          logger.debug "SAVE"
          format.html { redirect_to @user, notice: 'User was successfully created.' }
          format.json { render json: @user, status: :created, location: @user }
        else
          logger.debug "ERROR: #{@user.errors.inspect}"
          format.html { render action: "new" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      @user = User.find(params[:id])

      respond_to do |format|
        if @user.update_attributes(params[:user])
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy

      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end
    end

    def authorize_user_manager
      if !can? :manage, User
        flash[:error] = "Access denied"
        redirect_to root_url
      end
    end

  end
end