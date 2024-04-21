class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.order(:id).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
    return if @user == current_user

    redirect_to user_url(@user), notice: t('controllers.common.alert_update', name: User.model_name.human)
  end

  #
  # PATCH/PUT /users/1 or /users/1.json
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: t('controllers.common.notice_update', name: User.model_name.human) }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
